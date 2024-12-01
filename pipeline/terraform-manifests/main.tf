
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
    resource_group_name  = "Terraform"
    storage_account_name = "adminiegterraform"
    container_name       = "accounts"
    key                  = "test.tfstate"
  }
}

provider "azurerm" {
  features {}
}

