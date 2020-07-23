resource "azurerm_resource_group" "aks" {
  name                            = "${var.project}-${var.environment}-rg-aks"
  location                        = var.region
  tags = {
    environment                   = var.environment
  }
}

resource "azurerm_resource_group" "acr" {
  name                            = "${var.project}-${var.environment}-rg-acr"
  location                        = var.region
  tags = {
    environment                   = var.environment
  }
}

resource "azurerm_container_registry" "acr" {
  name                            = "${var.project}${var.environment}acr"
  resource_group_name             = azurerm_resource_group.acr.name
  location                        = var.region
  admin_enabled                   = "true"
  sku                             = "Premium"
  tags = {
    environment                   = var.environment
  }
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                            = "${var.project}-${var.environment}-aks"
  resource_group_name             = azurerm_resource_group.aks.name
  kubernetes_version              = var.aksversion
  location                        = var.region
  dns_prefix                      = "${var.project}${var.environment}aksdns"
  node_resource_group             = "${var.project}-${var.environment}-rg-aks-pool"

  default_node_pool {
    name                          = "devpool"
    vm_size                       = var.vm_size
    vnet_subnet_id                = azurerm_subnet.aks_nodes.id
    type                          = "VirtualMachineScaleSets"
    enable_auto_scaling           = "true"
    max_pods                      = 110
    max_count                     = 4
    min_count                     = 2 
    node_count                    = 4 
  }

  service_principal {
    client_id                     = data.azurerm_key_vault_secret.kv-appid.value
    client_secret                 = data.azurerm_key_vault_secret.kv-secret.value
  }

  network_profile {
    load_balancer_sku             = "standard"
    network_plugin                = "azure"
    network_policy                = "azure"
    dns_service_ip                = var.dns_service
    docker_bridge_cidr            = var.docker_bridge
    service_cidr                  = var.service_cidr
  }

  addon_profile {
    kube_dashboard {
      enabled                     = "true"
    }

    oms_agent {
      enabled                     = true
      #log_analytics_workspace_id  = azurerm_log_analytics_workspace.workspace.id
    }
  }

  api_server_authorized_ip_ranges = []

  enable_pod_security_policy      = "false"

  role_based_access_control {
    enabled                       = "true"
  }

  tags = {
    environment                   = var.environment
  }

lifecycle {
    # re-imported cluster means client secret is trying to regenerate mistakenly
    ignore_changes = [
      service_principal[0].client_secret,
      default_node_pool[0].node_count
    ]
  }
}

resource "azurerm_kubernetes_cluster_node_pool" "akssysnode" {
  name                  = "devsyspool"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  vm_size               = "Standard_B2s"
  node_count            = 1
  enable_auto_scaling   = "false"
  vnet_subnet_id        = azurerm_subnet.aks.id
  max_pods              = 30
  node_taints           = ["taint=disabled:NoSchedule"]

  tags = {
    environment         = var.environment
  }
}
