# Operations Runbook

## Application Health Check

Backend:

curl http://<alb-dns>/health

Frontend:

Open CloudFront URL in browser.

## Terraform Operations

Initialize:

terraform init

Plan:

terraform plan

Deploy:

terraform apply

Destroy:

terraform destroy

## Troubleshooting

### Backend Not Responding

Check:

* EC2 instance status
* Target Group health
* Security Groups
* CloudWatch Logs

### Frontend Not Loading

Check:

* S3 bucket contents
* CloudFront distribution status
* Browser cache

Invalidate CloudFront cache if necessary.

### MongoDB Connectivity Issues

Check:

* Atlas IP allow list
* Connection string
* Environment variables

### Auto Scaling Issues

Check:

* ASG desired capacity
* Launch Template configuration
* CloudWatch metrics

## Log Investigation

View logs in:

CloudWatch Logs → /starttech/backend

Common checks:

* Application startup logs
* API errors
* Database connection errors

## Rollback Procedure

Frontend:

Run rollback.sh

Backend:

Deploy previous Docker image version

Validate health endpoint after rollback.

## Escalation

1. Check CloudWatch alarms
2. Review application logs
3. Validate infrastructure state
4. Roll back to previous stable version if required
