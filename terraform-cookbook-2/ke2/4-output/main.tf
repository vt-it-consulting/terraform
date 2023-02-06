resource "azurerm_resource_group" "app" {
  name     = "app-resources"
  location = "West Europe"
}

resource "azurerm_app_service_plan" "app" {
  name                = "app-appserviceplan"
  location            = azurerm_resource_group.app.location
  resource_group_name = azurerm_resource_group.app.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_linux_web_app" "app" {
  name                = "app"
  resource_group_name = azurerm_resource_group.app.name
  location            = azurerm_app_service_plan.app.location
  service_plan_id     = azurerm_app_service_plan.app.id

  site_config {}
}


output "webapp_name" {
description = "output Name of the webapp"
value = azurerm_linux_web_app.app.name
}