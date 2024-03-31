resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = var.azurerm_kubernetes_cluster
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name
  dns_prefix          = "${azurerm_resource_group.aks_rg.name}-cluster"
  kubernetes_version  = var.orchestrator_version
  default_node_pool {
    name            = "system"
    node_count      = 1
    vm_size         = var.sys_pool_size
    os_disk_size_gb = 30
    node_labels = {
      "nodepool-type" = "system"
    }
    tags = {
      "app" = "system-apps"
    }
  }
  role_based_access_control_enabled = true
  network_profile {
    network_plugin    = "azure"
    load_balancer_sku = "standard"
  }
  service_principal {
    client_id     = var.client_id
    client_secret = var.client_secret
  }
  tags = {
    "Created by" = "${var.created_by}"
  }
}
resource "azurerm_virtual_network" "aksvnet" {
  name                = var.aks_vnet_name
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name
  address_space       = var.aks_vnet_cidr
}
resource "azurerm_subnet" "aks-default" {
  name                 = var.aks_subnet_name
  virtual_network_name = azurerm_virtual_network.aksvnet.name
  resource_group_name  = azurerm_resource_group.aks_rg.name
  address_prefixes     = var.aks_subnet_cidr
}