module "databricks" {
  source = "./modules/databricks"
  databricks_workspaces = var.databricks_workspaces
}

/* module "datafactory" {
  source = "./modules/datafactory"
} */