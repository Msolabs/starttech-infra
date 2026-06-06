# =========================
# Provider & Region
# =========================
variable "aws_region" {
  default = "us-east-1"
}

# =========================
# Project Configuration
# =========================
variable "project_name" {
  default = "starttech"
}

variable "environment" {
  default = "prod"
}

# =========================
# Networking (VPC & Subnets)
# =========================
variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnet_a" {
  default = "10.0.1.0/24"
}

variable "public_subnet_b" {
  default = "10.0.2.0/24"
}

variable "private_subnet_a" {
  default = "10.0.11.0/24"
}

variable "private_subnet_b" {
  default = "10.0.12.0/24"
}

# =========================
# EC2 Configuration
# =========================
variable "ami_id" {
  description = "Amazon Linux AMI"
  type        = string
}