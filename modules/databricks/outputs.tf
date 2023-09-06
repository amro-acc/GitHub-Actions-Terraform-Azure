output "workspace_urls" {
  description = "Returns workspace url of databricks"
  depends_on  = [azurerm_databricks_workspace.databricks]
  value       = element(concat([for key in azurerm_databricks_workspace.databricks : key.workspace_url], [""]), 0)
}

output "workspace_ids" {
  description = "Returns workspace url of databricks"
  depends_on  = [azurerm_databricks_workspace.databricks]
  value       = element(concat([for key in azurerm_databricks_workspace.databricks : key.id], [""]), 0)
}
