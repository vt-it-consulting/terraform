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
 

resource "azurerm_resource_group" "vtitconsulting" {
  name     = var.resource_group_name
  location = var.location
}



resource "azurerm_storage_account" "vtitconsulting" {
  name                     =var.storage_acount_name
  resource_group_name      = azurerm_resource_group.vtitconsulting.name
  location                 = azurerm_resource_group.vtitconsulting.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "staging"
  }
}
