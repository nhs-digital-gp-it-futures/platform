resource "azurerm_resource_group" "virtual_network" {
  name                                  = "${var.project}-vnet-${var.environment}"
  location                              = "${var.region}"

  tags                                  = {
    environment                         = "${var.environment}"
  }
}

resource "azurerm_virtual_network" "vnet" {
  name                                  = "${var.project}-vnet-${var.environment}"
  location                              = "${var.region}"
  address_space                         = ["10.100.0.0/21"]
  resource_group_name                   = "${azurerm_resource_group.virtual_network.name}"

  tags                                  = {
    environment                         = "${var.environment}"
  }
}

resource "azurerm_subnet" "bastion" {
  name                                  = "${var.project}-bastion-${var.environment}"
  resource_group_name                   = "${azurerm_virtual_network.vnet.name}"
  virtual_network_name                  = "${azurerm_virtual_network.vnet.name}"
  address_prefix                        = "10.100.0.0/24"
}

resource "azurerm_subnet" "gateway" {
  name                                  = "${var.project}-gateway-${var.environment}"
  resource_group_name                   = "${azurerm_virtual_network.vnet.name}"
  virtual_network_name                  = "${azurerm_virtual_network.vnet.name}"
  address_prefix                        = "10.100.1.0/29"
}

resource "azurerm_subnet" "aks" {
  name                                  = "${var.project}-aks-${var.environment}"
  resource_group_name                   = "${azurerm_virtual_network.vnet.name}"
  virtual_network_name                  = "${azurerm_virtual_network.vnet.name}"
  address_prefix                        = "10.100.2.0/24"
}

resource "azurerm_subnet" "demo01" {
  name                                  = "${var.project}-aks-${var.environment}"
  resource_group_name                   = "${azurerm_virtual_network.vnet.name}"
  virtual_network_name                  = "${azurerm_virtual_network.vnet.name}"
  address_prefix                        = "10.100.3.0/24"
}

resource "azurerm_network_security_group" "bastion" {
  name                                  = "${var.project}-bastion-${var.environment}"
  location                              = "${var.region}"
  resource_group_name                   = "${azurerm_virtual_network.vnet.name}"
  tags = {
    environment                         = "${var.environment}"
  }
}

resource "azurerm_network_security_group" "gateway" {
  name                                  = "${var.project}-gateway-${var.environment}"
  location                              = "${var.region}"
  resource_group_name                   = "${azurerm_virtual_network.vnet.name}"
  tags                                  = {
    environment                         = "${var.environment}"
  }
}

resource "azurerm_network_security_group" "aks" {
  name                                  = "${var.project}-aks-${var.environment}"
  location                              = "${var.region}"
  resource_group_name                   = "${azurerm_virtual_network.vnet.name}"
  tags                                  = {
    environment                         = "${var.environment}"
  }
}

resource "azurerm_subnet_network_security_group_association" "bastion" {
  subnet_id                             = "${azurerm_subnet.bastion.id}"
  network_security_group_id             = "${azurerm_network_security_group.bastion.id}"
}

resource "azurerm_subnet_network_security_group_association" "gateway" {
  subnet_id                             = "${azurerm_subnet.gateway.id}"
  network_security_group_id             = "${azurerm_network_security_group.gateway.id}"
}

resource "azurerm_subnet_network_security_group_association" "aks" {
  subnet_id                             = "${azurerm_subnet.aks.id}"
  network_security_group_id             = "${azurerm_network_security_group.aks.id}"
}

resource "azurerm_public_ip" "Pip" {
  name                                  = "${var.project}-pip-${var.environment}"
  location                              = "${var.region}"
  resource_group_name                   = "${azurerm_virtual_network.vnet.name}"
  allocation_method                     = "Dynamic"
  sku                                   = "Basic"
  tags                                  = {
    environment                         = "${var.environment}"
  }



}

locals {
  backend_address_pool_name             = "${var.project}-appgw-${var.environment}-beap"
  frontend_port_name                    = "${var.project}-appgw-${var.environment}-feport"
  frontend_ip_configuration_name        = "${var.project}-appgw-${var.environment}-feip"
  http_setting_name                     = "${var.project}-appgw-${var.environment}-be-htst"
  listener_name                         = "${var.project}-appgw-${var.environment}-httplstn"
  request_routing_rule_name             = "${var.project}-appgw-${var.environment}-rqrt"
  redirect_configuration_name           = "${var.project}-appgw-${var.environment}-rdrcfg"
  gateway_ip_configuration              = "${var.project}-appgw-${var.environment}-gwip"
}

resource "azurerm_application_gateway" "AppGate" {
    name                                = "${var.project}-appgw-${var.environment}"
    location                            = "${var.region}"
    resource_group_name                 = "${azurerm_virtual_network.vnet.name}"

    sku {
    name                                = "WAF_Medium"
    tier                                = "WAF"
    capacity                            = 2

    }
    
    gateway_ip_configuration {
    name                                = "${var.project}-gwip"
    subnet_id                           = "${azurerm_subnet.gateway.id}"
    }
 
    frontend_port {
    name                                = "${local.frontend_port_name}"
    port                                = 80
    }

      frontend_ip_configuration {
    name                                = "${local.frontend_ip_configuration_name}"
    public_ip_address_id                = "${azurerm_public_ip.Pip.id}"
  }

    backend_address_pool {
    name                                = "${local.backend_address_pool_name}"
  }

    backend_http_settings {
    name                                = "${local.http_setting_name}"
    cookie_based_affinity               = "Disabled"
    path                                = "/path/"
    port                                = 443
    protocol                            = "Https"
    request_timeout                     = 1
    }

    http_listener {
    name                                = "${local.listener_name}"
    frontend_ip_configuration_name      = "${local.frontend_ip_configuration_name}"
    frontend_port_name                  = "${local.frontend_port_name}"
    protocol                            = "Http"
    }

    request_routing_rule {
    name                                = "${local.request_routing_rule_name}"
    rule_type                           = "Basic"
    http_listener_name                  = "${local.listener_name}"
    backend_address_pool_name           = "${local.backend_address_pool_name}"
    backend_http_settings_name          = "${local.http_setting_name}"
    }
}
