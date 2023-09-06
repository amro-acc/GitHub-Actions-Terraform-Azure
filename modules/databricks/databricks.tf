resource "azurerm_databricks_workspace" "databricks" {
  for_each = var.databricks_workspaces

  name                                  = each.value.name
  resource_group_name                   = each.value.resource_group_name
  location                              = each.value.location
  sku                                   = each.value.sku
  managed_resource_group_name           = try(each.value.managed_resource_group_name, null)
  public_network_access_enabled         = try(each.value.public_network_access_enabled, true)
  infrastructure_encryption_enabled     = each.value.sku == "premium" ? try(each.value.infrastructure_encryption_enabled, null) : null
  customer_managed_key_enabled          = each.value.sku == "premium" ? try(each.value.customer_managed_key_enabled, null) : null
  network_security_group_rules_required = try(each.value.public_network_access_enabled, false) == false ? try(each.value.network_security_group_rules_required, null) : null
  tags                                  = try(each.value.tags, null)

  dynamic "custom_parameters" {
    for_each = try(each.value, "custom_parameters", {}) == {} ? [] : [1]

    content {
      machine_learning_workspace_id = try(each.value.custom_parameters.machine_learning_workspace_id, null)
      nat_gateway_name              = try(each.value.custom_parameters.nat_gateway_name, null)
      public_ip_name                = try(each.value.custom_parameters.public_ip_name, null)
      no_public_ip                  = try(each.value.custom_parameters.no_public_ip, false)
      public_subnet_name            = try(data.azurerm_subnet.public_databricks[each.key].name, null)
      #public_subnet_name = try(each.value.custom_parameters.public_subnet_name, null)  //added by abhijit
      public_subnet_network_security_group_association_id = try(data.azurerm_subnet.public_databricks[each.key].id, null)
      private_subnet_name                                 = try(data.azurerm_subnet.private_databricks[each.key].name, null)
      #private_subnet_name = try(each.value.custom_parameters.private_subnet_name, null)  //added by abhijit
      private_subnet_network_security_group_association_id = try(data.azurerm_subnet.private_databricks[each.key].id, null)
      storage_account_name                                 = try(each.value.custom_parameters.storage_account_name, null)
      storage_account_sku_name                             = try(each.value.custom_parameters.storage_account_sku_name, null)
      virtual_network_id                                   = try(data.azurerm_virtual_network.databricks[each.key].id, null)
      vnet_address_prefix                                  = try(each.value.custom_parameters.vnet_address_prefix, null)
    }
  }
}

resource "databricks_git_credential" "databricks" {
  for_each = {
    for key, value in try(var.databricks_workspaces, {}) : key => value
    if try(value.git_username, null) != null
  }
  git_username          = each.value.git_username
  git_provider          = each.value.git_provider
  personal_access_token = each.value.personal_access_token
  depends_on = [
    azurerm_databricks_workspace.databricks
  ]
}
