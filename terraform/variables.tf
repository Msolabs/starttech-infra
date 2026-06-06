variable "aws_region" {
  default = "us-east-1"
}

variable "project_name" {
  default = "starttech"
}

variable "environment" {
  default = "prod"
}

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