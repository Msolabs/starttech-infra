output "backend_log_group" {
  value = aws_cloudwatch_log_group.backend.name
}

output "cpu_alarm_name" {
  value = aws_cloudwatch_metric_alarm.high_cpu.alarm_name
}

output "alb_alarm_name" {
  value = aws_cloudwatch_metric_alarm.alb_5xx.alarm_name
}