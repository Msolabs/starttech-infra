terraform {
  required_version = ">= 1.6"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

module "networking" {
  source = "./modules/networking"

  project_name     = var.project_name
  aws_region       = var.aws_region

  vpc_cidr         = var.vpc_cidr
  public_subnet_a  = var.public_subnet_a
  public_subnet_b  = var.public_subnet_b
  private_subnet_a = var.private_subnet_a
  private_subnet_b = var.private_subnet_b
}