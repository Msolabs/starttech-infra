mkdir -p terraform/modules/networking
mkdir -p terraform/modules/compute
mkdir -p terraform/modules/storage
mkdir -p terraform/modules/monitoring

mkdir scripts
mkdir monitoring

touch terraform/main.tf
touch terraform/variables.tf
touch terraform/outputs.tf
touch terraform/terraform.tfvars.example

touch scripts/deploy-infrastructure.sh

touch monitoring/cloudwatch-dashboard.json
touch monitoring/alarm-definitions.json
touch monitoring/log-insights-queries.txt

touch README.md
touch ARCHITECTURE.md
touch RUNBOOK.md