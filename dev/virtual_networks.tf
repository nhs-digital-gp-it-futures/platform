/*
    Place all vnets in this file.
*/
resource "azurerm_virtual_network" "vnet" {
  name                = "${var.project}-vnet-${var.environment}"
  location            = "${var.region}"
  address_space       = ["10.100.0.0/21"]
  resource_group_name = "${azurerm_resource_group.virtual_network.name}"

  tags = {
    environment = "${var.environment}"
  }
}