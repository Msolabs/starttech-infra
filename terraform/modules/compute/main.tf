

# =========================
# Amazon Linux 2023 AMI
# =========================

data "aws_ami" "amazon_linux" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}


# =========================
# SECURITY GROUPS
# =========================

resource "aws_security_group" "alb" {
  name        = "${var.project_name}-alb-sg"
  description = "ALB Security Group"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "backend" {
  name   = "${var.project_name}-backend-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# =========================
# LOAD BALANCER LAYER
# =========================

resource "aws_lb_target_group" "backend" {
  name     = "${var.project_name}-tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/health"
    protocol            = "HTTP"
    matcher             = "200"
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb" "backend" {
  name               = "${var.project_name}-alb"
  load_balancer_type = "application"

  security_groups = [
    aws_security_group.alb.id
  ]

  subnets = [
    var.public_subnet_a_id,
    var.public_subnet_b_id
  ]
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.backend.arn

  port     = 80
  protocol = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.backend.arn
  }
}

# =========================
# IAM CONFIGURATION
# =========================

resource "aws_iam_role" "ec2_role" {
  name = "${var.project_name}-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "cloudwatch" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "${var.project_name}-instance-profile"
  role = aws_iam_role.ec2_role.name
}

# =========================
# COMPUTE LAYER (ASG)
# =========================

resource "aws_launch_template" "backend" {
  name_prefix   = "${var.project_name}-lt"
  image_id      = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type

  vpc_security_group_ids = [
    aws_security_group.backend.id
  ]

  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_profile.name
  }

 user_data = base64encode(<<EOF
#!/bin/bash

dnf update -y

cat > /tmp/server.py <<'PYTHON'
from http.server import BaseHTTPRequestHandler, HTTPServer

class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        if self.path == "/health":
            self.send_response(200)
            self.end_headers()
            self.wfile.write(b"OK")
        else:
            self.send_response(200)
            self.end_headers()
            self.wfile.write(b"StartTech Backend Running")

HTTPServer(("0.0.0.0", 8080), Handler).serve_forever()
PYTHON

python3 /tmp/server.py &
EOF
)
tag_specifications {
  resource_type = "instance"

  tags = {
    Name = "${var.project_name}-backend"
  }
}
}
resource "aws_autoscaling_group" "backend" {
  name = "${var.project_name}-asg"

  desired_capacity = 1
  min_size         = 1
  max_size         = 2

  vpc_zone_identifier = [
    var.private_subnet_a_id,
    var.private_subnet_b_id
  ]

  target_group_arns = [
    aws_lb_target_group.backend.arn
  ]

  launch_template {
    id      = aws_launch_template.backend.id
    version = "$Latest"
  }

  health_check_type = "ELB"
}

resource "aws_autoscaling_policy" "cpu_scaling" {
  name                   = "${var.project_name}-cpu-scaling"
  autoscaling_group_name = aws_autoscaling_group.backend.name

  policy_type = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 70
  }
}