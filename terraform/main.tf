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

data "azurerm_client_config" "current" {}

#Create Resource Group
resource "azurerm_resource_group" "tfdevopsgithubsrg" {
  name     = "tfdevops-githubs-rg"
  location = "canadacentral"
}

#Create Virtual Network
resource "azurerm_virtual_network" "tfdevopsgithubvnet" {
  name                = "myvnet"
  address_space       = ["192.168.0.0/16"]
  location            = azurerm_resource_group.tfdevopsgithubsrg.location
  resource_group_name = azurerm_resource_group.tfdevopsgithubsrg.name
}

# Create Subnet
resource "azurerm_subnet" "tfdevopsgithubsubnet" {
  name                 = "mysubnet"
  resource_group_name  = azurerm_resource_group.tfdevopsgithubsrg.name
  virtual_network_name = azurerm_virtual_network.tfdevopsgithubvnet.name
  address_prefix       = "192.168.0.0/24"
}