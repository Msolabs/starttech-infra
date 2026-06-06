output "alb_dns_name" {
  value       = aws_lb.backend.dns_name
  description = "DNS name of the Application Load Balancer"
}

output "target_group_arn" {
  value       = aws_lb_target_group.backend.arn
  description = "ARN of backend target group"
}

output "backend_security_group_id" {
  value       = aws_security_group.backend.id
  description = "Security group ID for backend EC2 instances"
}

output "alb_arn" {
  value       = aws_lb.backend.arn
  description = "ARN of Application Load Balancer"
}

output "asg_name" {
  value       = aws_autoscaling_group.backend.name
  description = "Name of backend Auto Scaling Group"
}