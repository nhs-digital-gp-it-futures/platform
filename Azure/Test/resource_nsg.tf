resource "azurerm_network_security_group" "gateway" {
  name                = "${var.project}-${var.environment}-${var.nsg}-gateway"
  location            = var.region
  resource_group_name = azurerm_resource_group.vnet.name
  tags = {
    environment = var.environment
  }
}

resource "azurerm_subnet_network_security_group_association" "gateway" {
  subnet_id                 = azurerm_subnet.gateway.id
  network_security_group_id = azurerm_network_security_group.gateway.id
}

resource "azurerm_network_security_group" "splunk" {
  name                = "${var.project}-${var.environment}-${var.nsg}-splunk"
  location            = var.region
  resource_group_name = azurerm_resource_group.vnet.name
  tags = {
    environment = var.environment
  }
}

resource "azurerm_network_security_rule" "BWP" {
  name                        = "AllowBwpGovIp"
  resource_group_name         = azurerm_resource_group.vnet.name
  network_security_group_name = azurerm_network_security_group.gateway.name
  destination_address_prefix  = "*"
  source_address_prefix       = var.gov_ip_add
  source_port_range           = "*"
  destination_port_ranges     = ["80","443"]
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  priority                    = "150"
  description                 = "Allow staff access who work within Bridgewater Place"
}

resource "azurerm_network_security_rule" "BJSS" {
  name                        = "AllowBjssVpn"
  resource_group_name         = azurerm_resource_group.vnet.name
  network_security_group_name = azurerm_network_security_group.gateway.name
  source_address_prefix       = var.bjss_ip_add
  destination_address_prefix  = "*"
  source_port_range           = "*"
  destination_port_ranges     = ["80","443"]
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  priority                    = "160"
  description                 = "Allow staff access who are connect to the BJSS VPN"
}

resource "azurerm_network_security_rule" "DevOps" {
  name                        = "AllowAzureDevOps"
  resource_group_name         = azurerm_resource_group.vnet.name
  network_security_group_name = azurerm_network_security_group.gateway.name
  source_address_prefix       = "AzureCloud"
  destination_address_prefix  = "*"
  source_port_range           = "*"
  destination_port_ranges     = ["80","443"]
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  priority                    = "200"
  description                 = "Allow AzureDevOps access to this environment"
}

resource "azurerm_network_security_rule" "Azure" {
  name                        = "AllowAzureInfrastructurePorts"
  resource_group_name         = azurerm_resource_group.vnet.name
  network_security_group_name = azurerm_network_security_group.gateway.name
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  source_port_range           = "*"
  destination_port_range      = "65200-65535"
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  priority                    = "500"
  description                 = "Allow incoming Azure Gateway Manager and inbound virtual network traffic (VirtualNetwork tag) on the NSG."
}
