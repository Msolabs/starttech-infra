# StartTech Month 3 Assessment

## Overview

This repository contains the Infrastructure as Code implementation for the StartTech full-stack application platform.

The solution provisions AWS infrastructure using Terraform and supports automated deployment through GitHub Actions.

## Architecture

### Frontend

* React application
* Hosted in Amazon S3
* Delivered globally using CloudFront

### Backend

* Golang REST API
* EC2 Auto Scaling Group
* Application Load Balancer
* CloudWatch logging

### Database

* MongoDB Atlas

### Monitoring

* CloudWatch Log Groups
* CloudWatch Alarms
* Centralized application logging

## Terraform Modules

### Networking

* VPC
* Public Subnets
* Private Subnets
* Internet Gateway
* NAT Gateway
* Route Tables

### Compute

* Launch Template
* Auto Scaling Group
* Application Load Balancer
* Target Group
* IAM Roles

### Storage

* S3 Bucket
* CloudFront Distribution

### Monitoring

* CloudWatch Log Groups
* CloudWatch Alarms

## Deployment

Initialize Terraform:

terraform init

Validate:

terraform validate

Plan:

terraform plan

Deploy:

terraform apply

## Outputs

* CloudFront URL
* Frontend S3 Bucket
* CloudWatch Log Group
* AWS Region

## CI/CD

GitHub Actions automates:

* Infrastructure deployment
* Frontend deployment
* Backend deployment
* Security checks
* Build validation

## Security

* IAM least privilege access
* Security Groups
* CloudWatch monitoring
* Secrets stored using GitHub Secrets

## Author

Moshood Owolabi
