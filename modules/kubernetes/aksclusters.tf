/*
    There should probably only be a single cluster - if this changes it would be obvious
*/
resource "azurerm_kubernetes_cluster" "aks" {
  name                = "${var.project}-aks-${var.environment}"
  resource_group_name = "${azurerm_resource_group.aks.name}"
  location            = "${var.region}"
  dns_prefix          = "${var.project}aks${var.environment}"

  /*
    You can only have 100 agents (VMs) per pool, its incredibly unlikely you will need more than one pool.
  */
  agent_pool_profile {
    name            = "gpit1"
    count           = 1
    vm_size         = "Standard_D2_v3"
    os_type         = "Linux"
    os_disk_size_gb = 30
  }

  agent_pool_profile {
    name            = "gpit2"
    count           = 1
    vm_size         = "Standard_D2_v3"
    os_type         = "Linux"
    os_disk_size_gb = 30
  }

  service_principal {
    client_id     = "7bec6319-e5b2-4067-b0b8-c4c9e57c5f7f"
    client_secret = "BW42fv*84ekQ?TxTqq+lQKnf?/edSh+U"
  }

  tags = {
    Environment = "${var.environment}"
  }
}