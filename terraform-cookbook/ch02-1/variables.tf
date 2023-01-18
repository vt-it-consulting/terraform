
variable "resource_group_name" {
  default     = "rg_test"
  description = "The name of the resource group"
}


variable "location" {
  description = "The name of the Azure location"
  default     = "West Europe"
}

variable "storage_acount_name" {
  description = "The name of the storage account"
  type        = string
}