output "alb_dns_name" {
  value = aws_lb.backend.dns_name
}

output "target_group_arn" {
  value = aws_lb_target_group.backend.arn
}

output "backend_security_group_id" {
  value = aws_security_group.backend.id
}