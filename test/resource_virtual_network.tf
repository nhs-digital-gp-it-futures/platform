resource "azurerm_resource_group" "virtual_network" {
  name     = "${var.project}-${var.environment}-rg-vnet"
  location = var.region
  tags = {
    environment = var.environment
  }
}

resource "azurerm_virtual_network" "vnet" {
  name                = "${var.project}-vnet-${var.environment}"
  location            = var.region
  address_space       = [var.ip_addsp]
  resource_group_name = azurerm_resource_group.virtual_network.name
  tags = {
    environment = var.environment
  }
}

resource "azurerm_subnet" "aks" {
  name                 = "${var.project}-aks-${var.environment}"
  resource_group_name  = azurerm_virtual_network.vnet.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefix       = var.sub_aks
}

resource "azurerm_subnet" "bastion" {
  name                 = "${var.project}-bastion-${var.environment}"
  resource_group_name  = azurerm_virtual_network.vnet.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefix       = var.sub_bastion
}

resource "azurerm_subnet" "ehub" {
  name                 = "${var.project}-ehub-${var.environment}"
  resource_group_name  = azurerm_virtual_network.vnet.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefix       = var.sub_ehub
}

resource "azurerm_subnet" "gateway" {
  name                 = "${var.project}-gateway-${var.environment}"
  resource_group_name  = azurerm_virtual_network.vnet.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefix       = var.sub_gateway
}

resource "azurerm_subnet" "splunk" {
  name                 = "${var.project}-splunk-${var.environment}"
  resource_group_name  = azurerm_virtual_network.vnet.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefix       = var.sub_splunk
}

resource "azurerm_subnet" "vm" {
  name                 = "${var.project}-vm-${var.environment}"
  resource_group_name  = azurerm_virtual_network.vnet.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefix       = var.sub_vm
}

resource "azurerm_network_security_group" "gateway" {
  name                = "${var.project}-gateway-${var.environment}"
  location            = var.region
  resource_group_name = azurerm_virtual_network.vnet.name
  tags = {
    environment = var.environment
  }
}

resource "azurerm_network_security_group" "aks" {
  name                = "${var.project}-aks-${var.environment}"
  location            = var.region
  resource_group_name = azurerm_virtual_network.vnet.name
  tags = {
    environment = var.environment
  }
}

resource "azurerm_network_security_group" "bastion" {
  name                = "${var.project}-bastion-${var.environment}"
  location            = var.region
  resource_group_name = azurerm_virtual_network.vnet.name
  tags = {
    environment = var.environment
  }
}

resource "azurerm_network_security_group" "splunk" {
  name                = "${var.project}-splunk-${var.environment}"
  location            = var.region
  resource_group_name = azurerm_virtual_network.vnet.name
  tags = {
    environment = var.environment
  }
}

resource "azurerm_public_ip" "Pip" {
  name                = "${var.project}-pip-${var.environment}"
  location            = var.region
  resource_group_name = azurerm_virtual_network.vnet.name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags = {
    environment = var.environment
  }
}

locals {
  backend_address_pool_name      = "${var.project}-appgw-${var.environment}-beap"
  frontend_port_name             = "${var.project}-appgw-${var.environment}-feport"
  frontend_ip_configuration_name = "${var.project}-appgw-${var.environment}-feip"
  http_setting_name              = "${var.project}-appgw-${var.environment}-be-htst"
  listener_name                  = "${var.project}-appgw-${var.environment}-httplstn"
  request_routing_rule_name      = "${var.project}-appgw-${var.environment}-rqrt"
  redirect_configuration_name    = "${var.project}-appgw-${var.environment}-rdrcfg"
  gateway_ip_configuration       = "${var.project}-appgw-${var.environment}-gwip"
}

resource "azurerm_application_gateway" "AppGate" {
  name                = "${var.project}-appgw-${var.environment}"
  location            = var.region
  resource_group_name = azurerm_virtual_network.vnet.name

  sku {
    name     = var.waf_name
    tier     = var.waf_tier
    capacity = var.waf_capacity
  }

  gateway_ip_configuration {
    name      = "${var.project}-gwip"
    subnet_id = azurerm_subnet.gateway.id
  }

  frontend_port {
    name = local.frontend_port_name
    port = 80
  }

  frontend_ip_configuration {
    name                 = local.frontend_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.Pip.id
  }

  backend_address_pool {
    name = local.backend_address_pool_name
  }

  backend_http_settings {
    name                  = local.http_setting_name
    cookie_based_affinity = "Disabled"
    path                  = "/path/"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 1
  }

  http_listener {
    name                           = local.listener_name
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    frontend_port_name             = local.frontend_port_name
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = local.request_routing_rule_name
    rule_type                  = "Basic"
    http_listener_name         = local.listener_name
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = local.http_setting_name
  }
}