

variable "resource_group_name" {
  description = "The name of the resource group"
}
variable "location" {
  description = "The name of the Azure location"
  default     = "West Europe"
}



resource "azurerm_resource_group" "rg" {
  name     = "My-RG"
  location = "West Europe"
}