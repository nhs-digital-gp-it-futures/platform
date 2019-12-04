resource "azurerm_resource_group" "aks" {
  name                          = "${var.project}-${var.environment}-rg-aks"
  location                      = var.region
  tags                          = {
    environment                 = var.environment
  }
}

resource "azurerm_resource_group" "acr" {
  name                          = "${var.project}-${var.environment}-rg-acr"
  location                      = var.region
  tags                          = {
    environment                 = var.environment
  }
}

resource "azurerm_container_registry" "acr" {
  name                          = "${var.project}acr${var.environment}"
  resource_group_name           = azurerm_resource_group.acr.name
  location                      = var.region
  admin_enabled                 = "true"
  sku                           = "standard"

  tags                          = {
    environment                 = var.environment
  }
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                          = "${var.project}-aks-${var.environment}"
  resource_group_name           = azurerm_resource_group.aks.name
  kubernetes_version            = var.aksversion
  location                      = var.region
  dns_prefix                    = "${var.project}aksdns${var.environment}"
  node_resource_group           = "${var.project}-akspool-${var.environment}"

  default_node_pool {
    name                        = "testpool1"
    vm_size                     = var.vm_size
    os_disk_size_gb             = 30
    vnet_subnet_id              = azurerm_subnet.aks.id
    type                        = "VirtualMachineScaleSets"
    enable_auto_scaling         = "true"
    max_pods                    = 10
    min_count                   = 2
    node_count                  = 2
  }

  service_principal {
    client_id                   = data.azurerm_key_vault_secret.kv-appid.value
    client_secret               = data.azurerm_key_vault_secret.kv-secret.value
  }

  network_profile {
    network_plugin              = "azure"
    network_policy              = "azure"
    dns_service_ip              = "10.110.49.111"
    docker_bridge_cidr          = "172.17.49.1/24"
    service_cidr                = "10.110.49.0/24"
    load_balancer_sku           = "standard"
  }

  addon_profile {
    kube_dashboard {
      enabled                   = true
    }
  }

  enable_pod_security_policy    = "true"
  
  role_based_access_control {
    enabled = "true"
  }

  tags                          = {
    environment                 = var.environment
  }
}