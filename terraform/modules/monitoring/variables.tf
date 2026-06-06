variable "project_name" {
  type        = string
  description = "Project name prefix"
}

variable "alb_arn" {
  type        = string
  description = "Application Load Balancer ARN"
}

variable "asg_name" {
  type        = string
  description = "Auto Scaling Group name"
}