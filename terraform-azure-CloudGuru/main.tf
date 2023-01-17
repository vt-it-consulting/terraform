# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
  subscription_id = "faa9cc4b-04c5-470b-8df0-e462f044996c"
}


# Create a resource group
resource "azurerm_resource_group" "vt_terraform" {
  name     = "Terraform-RG"
  location = "West Europe"
  tags = {
    environment = "staging"
  }
}


resource "azurerm_storage_account" "vt_terraform" {
  name                     = "vtitconsulting"
  resource_group_name      = azurerm_resource_group.vt_terraform.name
  location                 = azurerm_resource_group.vt_terraform.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "staging"
  }
}

resource "azurerm_storage_container" "vt_terraform" {
  name                  = "messdaten-out"
  storage_account_name  = azurerm_storage_account.vt_terraform.name
  container_access_type = "private"
}

