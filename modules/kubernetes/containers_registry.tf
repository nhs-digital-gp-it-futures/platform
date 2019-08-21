/*
    There should probably only be a single cluster - if this changes it would be obvious
*/
resource "azurerm_container_registry" "aks" {
  name                = "${var.project}aks${var.environment}"
  resource_group_name = "${azurerm_resource_group.aks.name}"
  location            = "${var.region}"
  admin_enabled       = "true"
  sku                 = "standard"

  tags = {
    Environment = "var.environment"
  }
}

