
variable "application_name" {
  description = "The name of application"
  type = string
  default = "Test"
}

variable "environment_name" {
  description = "The name of environment"
    type = string
  default = "Development"
}

variable "country_code" {
  description = "The country code (FR-US-...)"
    type = string
  default = "DE"
}

locals {
  resource_name = "upper(${var.application_name}-${var.environment_name}-${var.country_code})"
}

resource "azurerm_resource_group" "rg" {
  name     = "RG-${local.resource_name}"
  location = "West Europe"
}



resource "azurerm_public_ip" "pip" {
  name                = "acceptanceTestPublicIp1"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = "Static"

  tags = {
    environment = "Production"
  }
}