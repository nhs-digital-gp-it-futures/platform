resource "azurerm_network_security_group" "bastion" {
  name                = "${var.project}-${var.environment}-${var.nsg}-bastion"
  location            = "${var.region}"
  resource_group_name = "${azurerm_resource_group.vnet.name}"
  tags = {
    environment = "${var.environment}"
  }
}

resource "azurerm_network_security_group" "gateway" {
  name                = "${var.project}-${var.environment}-${var.nsg}-gateway"
  location            = "${var.region}"
  resource_group_name = "${azurerm_resource_group.vnet.name}"
  tags = {
    environment = "${var.environment}"
  }
}

resource "azurerm_network_security_group" "splunk" {
  name                = "${var.project}-${var.environment}-${var.nsg}-splunk"
  location            = "${var.region}"
  resource_group_name = "${azurerm_resource_group.vnet.name}"
  tags = {
    environment = "${var.environment}"
  }
}

resource "azurerm_network_security_group" "vm" {
  name                = "${var.project}-${var.environment}-${var.nsg}-vm"
  location            = "${var.region}"
  resource_group_name = "${azurerm_resource_group.vnet.name}"
  tags = {
    environment = "${var.environment}"
  }
}
