/*
    There should probably only be a single cluster - if this changes it would be obvious
*/
resource "azurerm_kubernetes_cluster" "aks" {
  name                = "${var.project}-aks-${var.environment}"
  location            = "${azurerm_resource_group.aks.location}"
  resource_group_name = "${azurerm_resource_group.aks.name}"
  dns_prefix          = "${var.project}aks${var.environment}"

  /*
    You can only have 100 agents (VMs) per pool, its incredibly unlikely you will need more than one pool.
  */
  agent_pool_profile {
    name            = "default"
    count           = 1
    vm_size         = "Standard_D2_v3"
    os_type         = "Linux"
    os_disk_size_gb = 30
  }

  service_principal {
    client_id     = "${var.app_id}"
    client_secret = "${var.password}"
  }

  tags = {
    Environment = "${var.environment}"
  }
}
