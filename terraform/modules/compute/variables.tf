variable "project_name" {
  type        = string
  description = "Name prefix for all resources"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID where compute resources will be deployed"
}

variable "public_subnet_a_id" {
  type        = string
  description = "Public subnet A ID for ALB placement"
}

variable "public_subnet_b_id" {
  type        = string
  description = "Public subnet B ID for ALB placement"
}

variable "private_subnet_a_id" {
  type        = string
  description = "Private subnet A ID for backend instances"
}

variable "private_subnet_b_id" {
  type        = string
  description = "Private subnet B ID for backend instances"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type for backend servers"

  default = "t3.micro"

  validation {
    condition     = can(regex("t2|t3", var.instance_type))
    error_message = "Only t2 or t3 instance types are allowed for cost control."
  }
}

variable "ami_id" {
  type        = string
  description = "AMI ID for backend EC2 instances"

  validation {
    condition     = length(var.ami_id) > 10
    error_message = "AMI ID must be a valid EC2 AMI identifier."
  }
}