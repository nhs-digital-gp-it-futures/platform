resource "azurerm_network_security_group" "gateway" {
  name                = "${var.project}-${var.environment}-${var.nsg}-gateway"
  location            = var.region
  resource_group_name = azurerm_resource_group.vnet.name
  tags = {
    environment = var.environment
  }
}

resource "azurerm_network_security_group" "splunk" {
  name                = "${var.project}-${var.environment}-${var.nsg}-splunk"
  location            = var.region
  resource_group_name = azurerm_resource_group.vnet.name
  tags = {
    environment = var.environment
  }
}

resource "azurerm_network_security_rule" "Public" {
  name                        = "Public"
  resource_group_name         = azurerm_resource_group.vnet.name
  network_security_group_name = azurerm_network_security_group.gateway.name
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  source_port_range           = "*"
  destination_port_ranges     = [ "80", "433"  ]
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "TCP"
  priority                    = "161"
  description                 = "Allow public access"
}

resource "azurerm_network_security_rule" "DevOps" {
  name                        = "AllowAzureDevOps"
  resource_group_name         = azurerm_resource_group.vnet.name
  network_security_group_name = azurerm_network_security_group.gateway.name
  source_address_prefix       = "AzureCloud"
  destination_address_prefix  = "*"
  source_port_range           = "*"
  destination_port_ranges     = [ "80", "433"  ]
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "TCP"
  priority                    = "200"
  description                 = "Allow AzureDevops Access to Kubernetes Cluster"

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
  protocol                    = "TCP"
  priority                    = "500"
  description                 = "Allow incoming Azure Gateway Manager and inbound virtual network traffic (VirtualNetwork tag) on the NSG."

}


