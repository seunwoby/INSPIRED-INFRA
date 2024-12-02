
terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.50.0"
    }

    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "terraform-storage-rg"
    storage_account_name = "sroterraformstatex"
    container_name       = "tfstateaks"
    key                  = "testservice-account.tfstate"
  }
}

provider "azurerm" {
  features {}
}

