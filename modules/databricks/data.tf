data "azurerm_resource_group" "databricks" {
  for_each = var.databricks_workspaces
  name     = each.value.resource_group_name
}

data "azurerm_virtual_network" "databricks" {
  for_each = {
    for key, value in var.databricks_workspaces : key => value
    if lookup(lookup(value, "custom_parameters", {}), "vnet_name", null) != null
  }
  name                = each.value.custom_parameters.vnet_name
  resource_group_name = each.value.custom_parameters.vnet_rg
}

data "azurerm_subnet" "public_databricks" {
  for_each = {
    for key, value in var.databricks_workspaces : key => value
    if lookup(lookup(value, "custom_parameters", {}), "public_subnet_name", null) != null
  }
  name                 = each.value.custom_parameters.public_subnet_name
  virtual_network_name = each.value.custom_parameters.vnet_name
  resource_group_name  = each.value.custom_parameters.vnet_rg
}

data "azurerm_subnet" "private_databricks" {
  for_each = {
    for key, value in var.databricks_workspaces : key => value
    if lookup(lookup(value, "custom_parameters", {}), "private_subnet_name", null) != null
  }
  name                 = each.value.custom_parameters.private_subnet_name
  virtual_network_name = each.value.custom_parameters.vnet_name
  resource_group_name  = each.value.custom_parameters.vnet_rg
}
