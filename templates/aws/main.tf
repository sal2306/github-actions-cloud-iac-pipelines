terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    # Dynamically configured via backend.conf
  }
}

provider "aws" {
  region = var.aws_region
}

resource "aws_resourcegroups_group" "example" {
  name = "group-${var.project_name}-${var.environment}"
  resource_query {
    query = <<JSON
{
  "ResourceTypeFilters": ["AWS::AllSupported"],
  "TagFilters": [
    {
      "Key": "Environment",
      "Values": ["${var.environment}"]
    }
  ]
}
JSON
  }
}

variable "project_name" { type = string }
variable "environment" { type = string }
variable "aws_region" { type = string }
