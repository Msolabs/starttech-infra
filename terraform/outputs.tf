output "region" {
  value = var.aws_region
}

output "frontend_bucket" {
  value = module.storage.bucket_name
}

output "cloudfront_url" {
  value = module.storage.cloudfront_domain_name
}

output "backend_log_group" {
  value = module.monitoring.backend_log_group
}