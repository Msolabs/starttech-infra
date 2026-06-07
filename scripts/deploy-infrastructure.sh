#!/bin/bash

terraform init
terraform fmt -recursive
terraform validate
terraform plan
terraform apply -auto-approve