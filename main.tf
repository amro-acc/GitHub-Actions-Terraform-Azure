resource "azurerm_resource_group" "rg-actions" {
  name     = var.resource_group_name
  location = var.location
}
