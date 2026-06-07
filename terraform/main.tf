# =========================
# Terraform Version & Providers
# =========================
terraform {
  required_version = ">= 1.6"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# =========================
# AWS Provider Configuration
# =========================
provider "aws" {
  region = var.aws_region
}

# =========================
# Networking Module
# =========================
module "networking" {
  source = "./modules/networking"

  project_name = var.project_name
  aws_region   = var.aws_region

  vpc_cidr         = var.vpc_cidr
  public_subnet_a  = var.public_subnet_a
  public_subnet_b  = var.public_subnet_b
  private_subnet_a = var.private_subnet_a
  private_subnet_b = var.private_subnet_b
}

# =========================
# Compute Module
# =========================
module "compute" {
  source = "./modules/compute"

  project_name = var.project_name

  vpc_id = module.networking.vpc_id

  public_subnet_a_id = module.networking.public_subnet_a_id
  public_subnet_b_id = module.networking.public_subnet_b_id

  private_subnet_a_id = module.networking.private_subnet_a_id
  private_subnet_b_id = module.networking.private_subnet_b_id

  instance_type = var.instance_type
}


# =========================
# Storage Module
# =========================

module "storage" {
  source = "./modules/storage"

  project_name = var.project_name
  environment  = var.environment
}

module "cache" {
  source = "./modules/cache"

  project_name = var.project_name

  vpc_id = module.networking.vpc_id

  private_subnet_a_id = module.networking.private_subnet_a_id
  private_subnet_b_id = module.networking.private_subnet_b_id
}
# =========================
# Monitoring Module
# =========================

module "monitoring" {
  source = "./modules/monitoring"

  project_name = var.project_name

  alb_arn  = module.compute.alb_arn
  asg_name = module.compute.asg_name
}