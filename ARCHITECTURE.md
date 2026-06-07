# System Architecture

## High-Level Design

Internet Users
|
CloudFront
|
S3 Frontend
|
Application Load Balancer
|
Auto Scaling Group
|
Golang Backend API
|
MongoDB Atlas

CloudWatch collects application logs and metrics from backend services.

## Components

### Frontend Layer

* React SPA
* Amazon S3 static hosting
* CloudFront CDN

### Load Balancing Layer

* Application Load Balancer
* Health checks
* Traffic distribution

### Compute Layer

* EC2 instances
* Launch Template
* Auto Scaling Group

### Data Layer

* MongoDB Atlas
* Persistent application data

### Monitoring Layer

* CloudWatch Logs
* CloudWatch Metrics
* CloudWatch Alarms

## Availability

* Multi-subnet deployment
* Auto Scaling Group
* Load-balanced backend services

## Security

* Security Groups
* IAM Roles
* Private backend resources
* Controlled ingress and egress traffic
