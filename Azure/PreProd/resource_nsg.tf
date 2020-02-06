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

resource "azurerm_network_security_rule" "aks" {
    name = "AllowAzureCloudInBoundMp"
    priority = "150"
    direction = "Inbound"
    access = "Allow"
    protocol = "*"
    source_port_range = "*"
    destination_port_range = "*"
    source_address_prefix = "AzureCloud"
    destination_address_prefix = "51.132.43.48"
    resource_group_name = "${var.akspool_rg}"
    network_security_group_name = "${var.akspool_nsg}"
    description = "Allow AzureDevops Access to MarketingPage"
}

resource "azurerm_network_security_rule" "aks1" {
    name = "AllowAzureCloudInBoundPb"
    priority = "151"
    direction = "Inbound"
    access = "Allow"
    protocol = "*"
    source_port_range = "*"
    destination_port_range = "*"
    source_address_prefix = "AzureCloud"
    destination_address_prefix = "51.132.150.10"
    resource_group_name = "${var.akspool_rg}"
    network_security_group_name = "${var.akspool_nsg}"
    description = "Allow AzureDevops Access to PublicBrowse"
}

resource "azurerm_network_security_rule" "aks2" {
  name                        = "AllowDevAksMp"
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "TCP"
  priority                    = 160
  source_address_prefixes     = ["${var.gov_ip_add}"]
  source_port_range           = "*"
  destination_address_prefix  = "51.132.43.48"
  destination_port_range      = "80"
  description                 = "Gov public IP addresses which have access to this environment"
  resource_group_name         = "${var.akspool_rg}"
  network_security_group_name = "${var.akspool_nsg}"
}

resource "azurerm_network_security_rule" "aks3" {
  name                        = "AllowDevAksPb"
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "TCP"
  priority                    = 161
  source_address_prefixes     = ["${var.gov_ip_add}"]
  source_port_range           = "*"
  destination_address_prefix  = "51.132.150.10"
  destination_port_range      = "80"
  description                 = "Gov public IP addresses which have access to this environment"
  resource_group_name         = "${var.akspool_rg}"
  network_security_group_name = "${var.akspool_nsg}"
}