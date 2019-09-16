resource "azurerm_resource_group" "aks" {
  name                    = "${var.project}-aks-${var.environment}"
  location                = "${var.region}"

  tags = {
    environment           = "${var.environment}"
  }
}

resource "azurerm_container_registry" "aks" {
  name                    = "${var.project}aks${var.environment}"
  resource_group_name     = "${azurerm_resource_group.aks.name}"
  location                = "${var.region}"
  admin_enabled           = "true"
  sku                     = "standard"

  tags = {
    Environment           = "var.environment"
  }
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                  = "${var.project}-aks-${var.environment}"
  resource_group_name   = "${azurerm_resource_group.aks.name}"
  location              = "${var.region}"
  dns_prefix            = "${var.project}aksdns${var.environment}"
  node_resource_group   = "${var.project}-akspool-${var.environment}"

  agent_pool_profile {
    name                = "gpitdevpool1"
    count               = 1
    vm_size             = "Standard_D2_v3"
    os_type             = "Linux"
    os_disk_size_gb     = 30
    vnet_subnet_id      = "${azurerm_subnet.aks.id}"
  }

  service_principal {
    client_id           = "${data.azurerm_key_vault_secret.kv-appid.value}"
    client_secret       = "${data.azurerm_key_vault_secret.kv-secret.value}"
  }

  tags = {
    Environment         = "${var.environment}"
  }
}