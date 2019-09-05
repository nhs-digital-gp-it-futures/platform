/*
    There should probably only be a single cluster - if this changes it would be obvious
*/
resource "azurerm_kubernetes_cluster" "aks" {
  name                = "${var.project}-aks-${var.environment}"
  resource_group_name = "${azurerm_resource_group.aks.name}"
  location            = "${var.region}"
  dns_prefix          = "${var.project}aksdns${var.environment}"
  node_resource_group = "${var.project}-akspool-${var.environment}"
  /*
    You can only have 100 agents (VMs) per pool, its incredibly unlikely you will need more than one pool.
  */

  agent_pool_profile {
    name            = "gpitdevpool1"
    count           = 1
    vm_size         = "Standard_D2_v3"
    os_type         = "Linux"
    os_disk_size_gb = 30
    vnet_subnet_id  = "${azurerm_subnet.aks.id}"
  }

  service_principal {
    client_id     = ""
    client_secret = ""
  }

  tags = {
    Environment = "${var.environment}"
  }

 /*
   
addon_profile {
      oms_agent {
        enabled                    = true
        log_analytics_workspace_id = "${var.log_analytics_workspace_id}"
      }
    }

  */

}
