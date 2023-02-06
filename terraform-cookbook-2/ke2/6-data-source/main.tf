

variable "app_name" {
  default = "Plan-App"
}

variable "environement" {
  default = "DEV1"
}
variable "resource_group_name" {
  description = "The name of the resource group"
  default     = "RG-App-DEV1"
}
variable "location" {
  description = "The name of the Azure location"
  default     = "West Europe"
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}



data "terraform_remote_state" "service_plan_tfstate" {
  backend = "azurerm"
  config = {
    resource_group_name  = "rg_tfstate"
    storage_account_name = "storstate"
    container_name       = "tfbackends"
    key                  = "serviceplan.tfstate"
  }
}

resource "azurerm_app_service" "app" {
  name                = "${var.app_name}-${var.environement}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = data.terraform_remote_state.service_plan_tfstate.service_plan_id
}
