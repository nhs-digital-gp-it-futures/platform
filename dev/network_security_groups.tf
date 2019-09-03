/*
    Place all nsg's in this file.
*/
resource "azurerm_network_security_group" "bastion" {
  name                    = "${var.project}-bastion-${var.environment}"
  location                = "${var.region}"
  resource_group_name     = "${azurerm_virtual_network.vnet.name}"

  tags = {
    environment = "${var.environment}"
  }
}

resource "azurerm_network_security_group" "gateway" {
  name                    = "${var.project}-gateway-${var.environment}"
  location                = "${var.region}"
  resource_group_name     = "${azurerm_virtual_network.vnet.name}"

  tags = {
    environment = "${var.environment}"
  }
}

resource "azurerm_network_security_group" "aks" {
  name                    = "${var.project}-aks-${var.environment}"
  location                = "${var.region}"
  resource_group_name     = "${azurerm_virtual_network.vnet.name}"

  tags = {
    environment = "${var.environment}"
  }
}

resource "azurerm_network_security_group" "splunk" {
  name                    = "${var.project}-splunk-${var.environment}"
  location                = "${var.region}"
  resource_group_name     = "${azurerm_virtual_network.vnet.name}"

  tags = {
    environment = "${var.environment}"
  }
}

resource "azurerm_subnet_network_security_group_association" "bastion" {
  subnet_id                 = "${azurerm_subnet.bastion.id}"
  network_security_group_id = "${azurerm_network_security_group.bastion.id}"
}

resource "azurerm_subnet_network_security_group_association" "gateway" {
  subnet_id                 = "${azurerm_subnet.gateway.id}"
  network_security_group_id = "${azurerm_network_security_group.gateway.id}"
}

resource "azurerm_subnet_network_security_group_association" "aks" {
  subnet_id                 = "${azurerm_subnet.aks.id}"
  network_security_group_id = "${azurerm_network_security_group.aks.id}"
}

resource "azurerm_subnet_network_security_group_association" "splunk" {
  subnet_id                 = "${azurerm_subnet.splunk.id}"
  network_security_group_id = "${azurerm_network_security_group.splunk.id}"
}