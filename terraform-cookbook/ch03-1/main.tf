
terraform {
  required_version = ">= 0.12"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "${var.resource_group_name}-${var.environment}"
  location = var.location
  tags     = var.tags

}

resource "azurerm_app_service_plan" "plan_app" {
  name                = "${var.service_plan_name}-${var.environment}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}


locals {
  default_app_settings = {
    "DEFAULT_KEY1" = "DEFAULT_VAL1"
  }
}


resource "azurerm_app_service" "app" {
  for_each            = var.web_apps
  name                = upper(each.value["name"])
  location            = lookup(each.value, "location", "West Europe")
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.plan_app.id
  site_config {
    dotnet_framework_version = each.value["dotnet_framework_version"]
  }
  connection_string {
    name  = "DataBase"
    type  = "SQLServer"
    value = "Server=${each.value["serverdatabase_name"]};IntegratedSecurity=SSPI"
  }
}

resource "azurerm_network_security_group" "example" {
  name                = "acceptanceTestSecurityGroup1"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dynamic "security_rule" {
    for_each = var.ngs_rules
    content {
      name                       = security_rule.value["name"]
      priority                   = security_rule.value["priority"]
      direction                  = security_rule.value["direction"]
      access                     = security_rule.value["access"]
      protocol                   = security_rule.value["protocol"]
      source_port_range          = security_rule.value["source_port_range"]
      destination_port_range     = security_rule.value["destination_port_range"]
      source_address_prefix      = security_rule.value["source_address_prefix"]
      destination_address_prefix = security_rule.value["destination_address_prefix"]
    }
  }
}