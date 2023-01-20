

output "app_service_names" {
  value = [for app in azurerm_app_service.app : app.name]
}
