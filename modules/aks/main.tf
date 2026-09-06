resource "azurerm_kubernetes_cluster" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix
  kubernetes_version  = var.kubernetes_version

  oidc_issuer_enabled       = true
  workload_identity_enabled = true
  role_based_access_control_enabled = true

  default_node_pool {
    name                 = "system"
    vm_size              = "Standard_D4s_v5"
    node_count           = var.system_node_count
    vnet_subnet_id       = var.subnet_id
    auto_scaling_enabled = true
    min_count            = 2
    max_count            = 5
    only_critical_addons_enabled = true
  }

  identity {
    type = "SystemAssigned"
  }

  oms_agent {
    log_analytics_workspace_id = var.log_analytics_workspace_id
  }

  network_profile {
    network_plugin    = "azure"
    network_policy    = "azure"
    load_balancer_sku = "standard"
    outbound_type     = "loadBalancer"
  }

  tags = var.tags
}

resource "azurerm_kubernetes_cluster_node_pool" "workload" {
  name                  = "workload"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.this.id
  vm_size               = "Standard_D4s_v5"
  vnet_subnet_id        = var.subnet_id

  auto_scaling_enabled = true
  min_count            = 1
  max_count            = 10

  node_labels = {
    "workload-tier" = "general"
  }

  tags = var.tags
}
