/*
    Place all subnets in this file.
*/
resource "azurerm_subnet" "bastion" {
  name                      = "${var.project}-bastion-${var.environment}"
  resource_group_name       = "${azurerm_resource_group.vnet.name}"
  virtual_network_name      = "${azurerm_virtual_network.vnet.name}"
  address_prefix            = "10.10.0.0/24"
  network_security_group_id = "${azurerm_network_security_group.bastion.id}"
}

resource "azurerm_subnet" "gateway" {
  name                      = "${var.project}-gateway-${var.environment}"
  resource_group_name       = "${azurerm_resource_group.vnet.name}"
  virtual_network_name      = "${azurerm_virtual_network.vnet.name}"
  address_prefix            = "10.10.1.0/24"
  network_security_group_id = "${azurerm_network_security_group.gateway.id}"
}

resource "azurerm_subnet" "aks" {
  name                      = "${var.project}-aks-${var.environment}"
  resource_group_name       = "${azurerm_resource_group.vnet.name}"
  virtual_network_name      = "${azurerm_virtual_network.vnet.name}"
  address_prefix            = "10.10.2.0/24"
  network_security_group_id = "${azurerm_network_security_group.aks.id}"
}

resource "azurerm_subnet" "splunk" {
  name                      = "${var.project}-splunk-${var.environment}"
  resource_group_name       = "${azurerm_resource_group.vnet.name}"
  virtual_network_name      = "${azurerm_virtual_network.vnet.name}"
  address_prefix            = "10.10.3.0/24"
  network_security_group_id = "${azurerm_network_security_group.splunk.id}"
}