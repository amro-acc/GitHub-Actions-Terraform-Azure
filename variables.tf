variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  type        = string
  default     = "amit-actions-rg"
}

variable "location" {
  description = "Location for the Azure Resource Group"
  type        = string
  default     = "East US"
}
