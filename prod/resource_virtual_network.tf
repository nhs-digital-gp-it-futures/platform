resource "azurerm_resource_group" "vnet" {
  name                              = "${var.project}-${var.environment}-rg-vnet"
  location                          = "${var.region}"
  tags                              = {
    environment                     = "${var.environment}"
  }
}

resource "azurerm_virtual_network" "vnet" {
  name                              = "${var.project}-${var.environment}-vnet"
  location                          = "${var.region}"
  address_space                     = ["${var.ip_addsp}"]
  resource_group_name               = "${azurerm_resource_group.vnet.name}"
  tags                              = {
    environment                     = "${var.environment}"
  }
}

resource "azurerm_subnet" "aks" {
  name                              = "${var.project}-${var.environment}-${var.sub}-aks"
  resource_group_name               = "${azurerm_resource_group.vnet.name}"
  virtual_network_name              = "${azurerm_virtual_network.vnet.name}"
  address_prefix                    = "${var.sub_aks}"
}

resource "azurerm_subnet" "bastion" {
  name                              = "${var.project}-${var.environment}-${var.sub}-bastion"
  resource_group_name               = "${azurerm_resource_group.vnet.name}"
  virtual_network_name              = "${azurerm_virtual_network.vnet.name}"
  address_prefix                    = "${var.sub_bastion}"
}

resource "azurerm_subnet" "ehub" {
  name                              = "${var.project}-${var.environment}-${var.sub}-ehub"
  resource_group_name               = "${azurerm_resource_group.vnet.name}"
  virtual_network_name              = "${azurerm_virtual_network.vnet.name}"
  address_prefix                    = "${var.sub_ehub}"
}

resource "azurerm_subnet" "gateway" {
  name                              = "${var.project}-${var.environment}-${var.sub}-gateway"
  resource_group_name               = "${azurerm_resource_group.vnet.name}"
  virtual_network_name              = "${azurerm_virtual_network.vnet.name}"
  address_prefix                    = "${var.sub_gateway}"
}

resource "azurerm_subnet" "splunk" {
  name                              = "${var.project}-${var.environment}-${var.sub}-splunk"
  resource_group_name               = "${azurerm_resource_group.vnet.name}"
  virtual_network_name              = "${azurerm_virtual_network.vnet.name}"
  address_prefix                    = "${var.sub_splunk}"
}

resource "azurerm_subnet" "vm" {
  name                              = "${var.project}-${var.environment}-${var.sub}-vm"
  resource_group_name               = "${azurerm_resource_group.vnet.name}"
  virtual_network_name              = "${azurerm_virtual_network.vnet.name}"
  address_prefix                    = "${var.sub_vm}"
}

resource "azurerm_network_security_group" "gateway" {
  name                              = "${var.project}-${var.environment}-${var.nsg}-gateway"
  location                          = "${var.region}"
  resource_group_name               = "${azurerm_resource_group.vnet.name}"
  tags                              = {
    environment                     = "${var.environment}"
  }
}

resource "azurerm_network_security_group" "aks" {
  name                              = "${var.project}-${var.environment}-${var.nsg}-aks"
  location                          = "${var.region}"
  resource_group_name               = "${azurerm_resource_group.vnet.name}"
  tags                              = {
    environment                     = "${var.environment}"
  }
}

resource "azurerm_network_security_group" "bastion" {
  name                              = "${var.project}-${var.environment}-${var.nsg}-bastion"
  location                          = "${var.region}"
  resource_group_name               = "${azurerm_resource_group.vnet.name}"
  tags                              = {
    environment                     = "${var.environment}"
  }
}

resource "azurerm_network_security_group" "splunk" {
  name                              = "${var.project}-${var.environment}-${var.nsg}-splunk"
  location                          = "${var.region}"
  resource_group_name               = "${azurerm_resource_group.vnet.name}"
  tags                              = {
    environment                     = "${var.environment}"
  }
}

resource "azurerm_network_security_group" "vm" {
  name                              = "${var.project}-${var.environment}-${var.nsg}-vm"
  location                          = "${var.region}"
  resource_group_name               = "${azurerm_resource_group.vnet.name}"
  tags                              = {
    environment                     = "${var.environment}"
  }
}

resource "azurerm_subnet_network_security_group_association" "aks" {
  subnet_id                         =   "${azurerm_subnet.aks.id}"
  network_security_group_id         =   "${azurerm_network_security_group.aks.id}"
}

resource "azurerm_subnet_network_security_group_association" "bastion" {
  subnet_id                         =   "${azurerm_subnet.bastion.id}"
  network_security_group_id         =   "${azurerm_network_security_group.bastion.id}"
}

resource "azurerm_subnet_network_security_group_association" "splunk" {
  subnet_id                         =   "${azurerm_subnet.splunk.id}"
  network_security_group_id         =   "${azurerm_network_security_group.splunk.id}"
}

resource "azurerm_subnet_network_security_group_association" "vm" {
  subnet_id                         =   "${azurerm_subnet.vm.id}"
  network_security_group_id         =   "${azurerm_network_security_group.vm.id}"
}

resource "azurerm_network_security_rule" "public_access" {
  name                              = "restricted_public_access"
  direction                         = "Inbound"
  access                            = "Allow"
  protocol                          = "TCP"
  priority                          = 100
  source_address_prefixes           = ["62.6.52.0/25", "62.6.52.128/25", "62.172.169.0/25", "85.115.52.0/24", "85.115.53.0/24", "85.115.54.0/24", "91.232.153.0/24", "193.84.224.0/24", "193.84.225.0", "194.176.105.0/24"]
  source_port_range                 = "80"
  destination_address_prefix        = "*"
  destination_port_range            = "*"
  description                       = "This is a list of Gov public IP addresses which have access to this environment"
  resource_group_name               = "${azurerm_resource_group.vnet.name}"
  network_security_group_name       = "${azurerm_network_security_group.aks.name}"
}

resource "azurerm_public_ip" "Pip" {
  name                              = "${var.project}-pip-${var.environment}"
  location                          = "${var.region}"
  resource_group_name               = "${azurerm_resource_group.vnet.name}"
  allocation_method                 = "Static"
  sku                               = "Standard"
  tags                              = {
    environment                     = "${var.environment}"
  }
}

locals {
  backend_address_pool_name         = "${var.project}-appgw-${var.environment}-beap"
  frontend_port_name                = "${var.project}-appgw-${var.environment}-feport"
  frontend_ip_configuration_name    = "${var.project}-appgw-${var.environment}-feip"
  http_setting_name                 = "${var.project}-appgw-${var.environment}-be-htst"
  listener_name                     = "${var.project}-appgw-${var.environment}-httplstn"
  request_routing_rule_name         = "${var.project}-appgw-${var.environment}-rqrt"
  redirect_configuration_name       = "${var.project}-appgw-${var.environment}-rdrcfg"
  gateway_ip_configuration          = "${var.project}-appgw-${var.environment}-gwip"
}

resource "azurerm_application_gateway" "AppGate" {
  name                              = "${var.project}-appgw-${var.environment}"
  location                          = "${var.region}"
  resource_group_name               = "${azurerm_resource_group.vnet.name}"

  sku {
    name                            = "${var.waf_name}"
    tier                            = "${var.waf_tier}"
    capacity                        = "${var.waf_capacity}"
  }

  gateway_ip_configuration {
    name                            = "${var.project}-gwip"
    subnet_id                       = "${azurerm_subnet.gateway.id}"
  }

  frontend_port {
    name                            = "${local.frontend_port_name}"
    port                            = 80
  }

  frontend_ip_configuration {
    name                            = "${local.frontend_ip_configuration_name}"
    public_ip_address_id            = "${azurerm_public_ip.Pip.id}"
  }

  backend_address_pool {
    name                            = "${local.backend_address_pool_name}"
  }

  backend_http_settings {
    name                            = "${local.http_setting_name}"
    cookie_based_affinity           = "Disabled"
    path                            = "/path/"
    port                            = 80
    protocol                        = "Http"
    request_timeout                 = 1
  }

  http_listener {
    name                            = "${local.listener_name}"
    frontend_ip_configuration_name  = "${local.frontend_ip_configuration_name}"
    frontend_port_name              = "${local.frontend_port_name}"
    protocol                        = "Http"
  }

  request_routing_rule {
    name                            = "${local.request_routing_rule_name}"
    rule_type                       = "Basic"
    http_listener_name              = "${local.listener_name}"
    backend_address_pool_name       = "${local.backend_address_pool_name}"
    backend_http_settings_name      = "${local.http_setting_name}"
  }
}