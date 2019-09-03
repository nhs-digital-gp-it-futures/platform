/*
    Place all subnets in this file.
*/
resource "azurerm_subnet" "bastion" {
  name                      = "${var.project}-bastion-${var.environment}"
  resource_group_name       = "${azurerm_virtual_network.vnet.name}"
  virtual_network_name      = "${azurerm_virtual_network.vnet.name}"
  address_prefix            = "10.100.0.0/24"
}

resource "azurerm_subnet" "gateway" {
  name                      = "${var.project}-gateway-${var.environment}"
  resource_group_name       = "${azurerm_virtual_network.vnet.name}"
  virtual_network_name      = "${azurerm_virtual_network.vnet.name}"
  address_prefix            = "10.100.1.0/24"
}

resource "azurerm_subnet" "aks" {
  name                      = "${var.project}-aks-${var.environment}"
  resource_group_name       = "${azurerm_virtual_network.vnet.name}"
  virtual_network_name      = "${azurerm_virtual_network.vnet.name}"
  address_prefix            = "10.100.2.0/24"
}

resource "azurerm_subnet" "splunk" {
  name                      = "${var.project}-splunk-${var.environment}"
  resource_group_name       = "${azurerm_virtual_network.vnet.name}"
  virtual_network_name      = "${azurerm_virtual_network.vnet.name}"
  address_prefix            = "10.100.3.0/24"
}