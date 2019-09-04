resource "azurerm_public_ip" "Pip" {
  name = "${var.project}-pip-${var.environment}"
  location = "${var.region}"
  resource_group_name = "${azurerm_virtual_network.vnet.name}"
  allocation_method = "Dynamic"
  sku = "Basic"

  tags = {
    environment = "${var.environment}"
    
  }



}
