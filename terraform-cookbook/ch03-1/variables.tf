

variable "app_name" {
  description = "Name of application"
  default     = "MyApp"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "location" {
  description = "Location of Azure reource"
  default     = "West Europe"
  type        = string
}

variable "nb_webapp" {
  description = "Number of App Service to create"
  type        = string
}

variable "service_plan_name" {
  description = "Service plan name"
  type        = string
}

variable "environment" {
  description = "Environment Name"
  type        = string
}


variable "tags" {
  type        = map(string)
  description = "Tags"
  default     = {}
}
variable "app_settings" {
  type        = map(string)
  description = "App settings of the App Service"
  default     = {}
}

variable "custom_app_settings" {
  description = "Custom app settings"
  type        = map(string)
  default     = {}
}

variable "web_apps" {
  description = "List of App Service to create"
  type        = any
}

variable "ngs_rules" {
  description = "List of NSG rules"
  type        = any
}