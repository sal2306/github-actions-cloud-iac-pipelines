terraform {
  required_version = ">= 1.5.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
  backend "azurerm" {
    # Dynamically configured via backend.conf
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "rg-${var.project_name}-${var.environment}"
  location = var.location
}

variable "project_name" { type = string }
variable "environment" { type = string }
variable "location" { type = string }
