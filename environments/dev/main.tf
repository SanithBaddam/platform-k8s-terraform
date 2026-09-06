terraform {
  backend "azurerm" {}
}

locals {
  tags = {
    environment = "dev"
    managed_by  = "terraform"
    owner       = "platform-engineering"
  }
}

resource "azurerm_resource_group" "this" {
  name     = "rg-platform-dev"
  location = var.location
  tags     = local.tags
}

resource "azurerm_log_analytics_workspace" "this" {
  name                = "log-platform-dev"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
  tags                = local.tags
}

module "network" {
  source               = "../../modules/network"
  resource_group_name  = azurerm_resource_group.this.name
  location             = azurerm_resource_group.this.location
  name                 = "vnet-platform-dev"
  address_space        = ["10.20.0.0/16"]
  aks_subnet_prefixes  = ["10.20.1.0/24"]
  tags                 = local.tags
}

module "aks" {
  source                     = "../../modules/aks"
  name                       = "aks-platform-dev"
  resource_group_name        = azurerm_resource_group.this.name
  location                   = azurerm_resource_group.this.location
  dns_prefix                 = "platform-dev"
  subnet_id                  = module.network.aks_subnet_id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.this.id
  tags                       = local.tags
}
