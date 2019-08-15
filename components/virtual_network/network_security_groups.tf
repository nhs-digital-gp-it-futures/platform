/*
    Place all nsg's in this file.
*/
resource "azurerm_network_security_group" "bastion" {
  name                = "${var.project}-bastion-${var.environment}"
  location            = "${var.region}"
  resource_group_name = "${azurerm_resource_group.vnet.name}"

  tags = {
    environment = "${var.environment}"
  }
}

resource "azurerm_network_security_group" "gateway" {
  name                = "${var.project}-gateway-${var.environment}"
  location            = "${var.region}"
  resource_group_name = "${azurerm_resource_group.vnet.name}"

  tags = {
    environment = "${var.environment}"
  }
}

resource "azurerm_network_security_group" "aks" {
  name                = "${var.project}-aks-${var.environment}"
  location            = "${var.region}"
  resource_group_name = "${azurerm_resource_group.vnet.name}"

  tags = {
    environment = "${var.environment}"
  }
}

resource "azurerm_network_security_group" "splunk" {
  name                = "${var.project}-splunk-${var.environment}"
  location            = "${var.region}"
  resource_group_name = "${azurerm_resource_group.vnet.name}"

  tags = {
    environment = "${var.environment}"
  }
}