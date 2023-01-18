# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}
 


variable "application_name" {
  description = "The name of application"
  default = "VT-IT-Consulting"
}

variable "environment_name" {
  description = "The name of environment"
  default = "Production"
}

variable "country_code" {
  description = "The country code (FR-US-...)"
  default = "DE"
}

locals {
  resource_name = "${var.application_name}-${var.environment_name}-${var.country_code}"
}
 
resource "azurerm_resource_group" "rg" {
  name     = "RG-${local.resource_name}" # VARIABLE TO USE
  location = "West Europe"
}

resource "azurerm_public_ip" "pip" {
  name                = "IP-${local.resource_name}" # VARIABLE TO USE
  location            = "West Europe"
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
  domain_name_label   = "mydomain"
}


