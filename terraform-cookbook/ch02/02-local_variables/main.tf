
terraform {
  required_version = ">= 0.12"
  required_providers {
    azurerm = {
      version = "3.39.1"
    }
  }
}

provider "azurerm"{
  features {}
}

variable "application_name" {
  description = "The name of application"
  default = "Local-VARIABLES"
}
variable "environment_name" {
  description = "The name of environment"
  default = "Development"
}
variable "country_code" {
  description = "The country code (FR-US-...)"
  default = "DE"
}

locals {
  resource_name = "${var.application_name}-${var.environment_name}-${var.country_code}"
}

resource "azurerm_resource_group" "rg" {
  name     = "RG-${local.resource_name}"
  location = "West Europe"
}
