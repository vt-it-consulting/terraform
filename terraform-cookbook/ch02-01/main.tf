
# Azure Provider source and version being used

# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.39.1"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}
variable "resource_group_name" {
  default = "RG-Terraform-Cookbook"
}

resource "azurerm_resource_group" "rg" {
  name     = "${var.resource_group_name}"
  location = "West Europe"
}