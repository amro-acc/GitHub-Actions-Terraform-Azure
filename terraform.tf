terraform {
    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
           version = ">= 3.7.0"
        }
    }
    backend "azurerm" {
        resource_group_name  = "amit-rg"
        storage_account_name = "amitstgtf"
        container_name       = "tfstate"
        key = "terraform.tfstate"
    }
}

provider "azurerm" {
  features {}
}