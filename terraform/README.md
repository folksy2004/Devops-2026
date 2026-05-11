# Terraform vSphere VM Deployment

Terraform project for deploying Ubuntu and CentOS virtual machines on VMware vSphere.

## Features

- Ubuntu VM deployment
- CentOS 9 VM deployment
- VMware vSphere provider
- Static IP configuration
- Reusable templates
- Auto deployment support

## Requirements

- Terraform
- VMware vCenter
- Existing VM templates
- SSH enabled on templates

## Usage

Initialize Terraform:

terraform init

Validate configuration:

terraform validate

Deploy CentOS:

terraform apply -var-file="Centos9.tfvars"

Deploy Ubuntu:

terraform apply -var-file="Ubuntu.tfvars"

Auto approve deployment:

terraform apply -var-file="Ubuntu.tfvars" -auto-approve
