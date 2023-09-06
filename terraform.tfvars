# resource_group_name = "rg-terraform-github-actions"
# location            = "eastus"

databricks_workspaces = {
  workspace1 = {
    name                          = "elex-demo-eu-dbw-0001"
    resource_group_name           = "elex-demo-eu2-rg-0001"
    location                      = "EastUS"
    sku                           = "trial"
    managed_resource_group_name   = "elex-demo-eu2-rg-0005" //dbw will create RG with this name
    public_network_access_enabled = true
    # infrastructure_encryption_enabled = false
    # customer_managed_key_enabled      = false
    /* git_username                      = "test"
    git_provider                      = "azureDevOpsServices"
    personal_access_token             = "sometoken"
    */
    # network_security_group_rules_required = "NoAzureDatabricksRules" // Required when public_network_access_enabled is set to false
    tags = {
      Environment = "demo"
      application = "application name"
      CostCenter  = "CostCenter code"
      department  = "Example dept"
      owner       = "Example Project owner"
    }
    custom_parameters = {
      #machine_learning_workspace_id = ""
      nat_gateway_name = "elex-nat-gateway"
      public_ip_name   = "elex-demo-eu2-ngwip-0001"
      # no_public_ip     = false
      # no_public_ip             = true
      public_subnet_name       = "elex-demo-eu2-snet-0001"
      private_subnet_name      = "elex-demo-eu2-snet-0002"
      vnet_name                = "elex-demo-eu2-vnet-0001"
      vnet_rg                  = "elex-demo-eu2-rg-0001"
      storage_account_name     = "elexdemoeu2sa0012"
      storage_account_sku_name = "Standard_LRS"
      #vnet_address_prefix = "" // Required for managed VNet
    }
  }
}
