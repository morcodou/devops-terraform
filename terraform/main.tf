terraform {
  backend "azurerm" {
    resource_group_name  = "gmteraformdevops"
    storage_account_name = "tfmdevopssac"
    container_name       = "tfmdevops"
    key                  = "tfmdevops.tfstate"
  }
}
 
provider "azurerm" {
  # The "feature" block is required for AzureRM provider 2.x.
  # If you're using version 1.x, the "features" block is not allowed.
  version                    = "~>2.0"
  skip_provider_registration = true
  features {}
}
