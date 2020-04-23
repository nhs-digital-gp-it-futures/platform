resource "azurerm_network_security_group" "gateway_pri" {
  name                = "${var.project}-${var.environment}-${var.nsg}-gateway-pri"
  location            = var.region
  resource_group_name = azurerm_resource_group.vnet.name
  tags = {
    environment = var.environment
  }
}

resource "azurerm_network_security_rule" "BWP_pri" {
  name                        = "AllowBwpGovIp"
  resource_group_name         = azurerm_resource_group.vnet.name
  network_security_group_name = azurerm_network_security_group.gateway_pri.name
  destination_address_prefix  = "*"
  source_address_prefix       = var.gov_ip_add
  source_port_range           = "*"
  destination_port_range      = "80,433"
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "TCP"
  priority                    = "150"
  description                 = "Allow staff access who work within Bridgewater Place"

}

resource "azurerm_network_security_rule" "BJSS_pri" {
  name                        = "AllowBjssVpn"
  resource_group_name         = azurerm_resource_group.vnet.name
  network_security_group_name = azurerm_network_security_group.gateway_pri.name
  source_address_prefix       = var.bjss_ip_add
  destination_address_prefix  = "*"
  source_port_range           = "*"
  destination_port_range      = "80,433"
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "TCP"
  priority                    = "160"
  description                 = "Allow staff access who are connect to the BJSS VPN"

}

resource "azurerm_network_security_rule" "DevOps_pri" {
  name                        = "AllowAzureDevOps"
  resource_group_name         = azurerm_resource_group.vnet.name
  network_security_group_name = azurerm_network_security_group.gateway_pri.name
  source_address_prefix       = "AzureCloud"
  destination_address_prefix  = "*"
  source_port_range           = "*"
  destination_port_range      = "80,433"
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "TCP"
  priority                    = "200"
  description                 = "Allow AzureDevops Access to Kubernetes Cluster Private"

}

resource "azurerm_network_security_rule" "Azure_pri" {
  name                        = "AllowAzureInfrastructurePorts"
  resource_group_name         = azurerm_resource_group.vnet.name
  network_security_group_name = azurerm_network_security_group.gateway_pri.name
  source_address_prefix       = var.gov_ip_add
  destination_address_prefix  = "*"
  source_port_range           = "*"
  destination_port_range      = "65200-65535"
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "TCP"
  priority                    = "500"
  description                 = "Allow incoming Azure Gateway Manager and inbound virtual network traffic (VirtualNetwork tag) on the NSG."

}


