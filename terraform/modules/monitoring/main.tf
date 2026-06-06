# =========================
# Backend Application Logs
# =========================

resource "aws_cloudwatch_log_group" "backend" {
  name              = "/starttech/backend"
  retention_in_days = 30
}

# =========================
# CPU Alarm
# =========================

resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name          = "${var.project_name}-high-cpu"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2

  metric_name = "CPUUtilization"
  namespace   = "AWS/EC2"

  period    = 300
  statistic = "Average"

  threshold = 80

  alarm_description = "High CPU utilization detected"

  dimensions = {
    AutoScalingGroupName = var.asg_name
  }
}

# =========================
# ALB 5XX Errors Alarm
# =========================

resource "aws_cloudwatch_metric_alarm" "alb_5xx" {

  alarm_name          = "${var.project_name}-alb-5xx"
  comparison_operator = "GreaterThanThreshold"

  evaluation_periods = 1

  metric_name = "HTTPCode_ELB_5XX_Count"
  namespace   = "AWS/ApplicationELB"

  period    = 300
  statistic = "Sum"

  threshold = 10

  alarm_description = "ALB returning excessive 5XX errors"
}