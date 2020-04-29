resource "azurerm_resource_group" "vnet" {
  name     = "${var.project}-${var.environment}-rg-vnet"
  location = var.region
  tags = {
    environment = var.environment
  }
}

resource "azurerm_virtual_network" "vnet" {
  name                = "${var.project}-${var.environment}-vnet"
  location            = var.region
  address_space       = [var.ip_addsp]
  resource_group_name = azurerm_resource_group.vnet.name
  tags = {
    environment = var.environment
  }
}

resource "azurerm_subnet" "aks" {
  name                 = "${var.project}-${var.environment}-${var.sub}-aks"
  resource_group_name  = azurerm_resource_group.vnet.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefix       = var.sub_aks
}

resource "azurerm_subnet" "ehub" {
  name                 = "${var.project}-${var.environment}-${var.sub}-ehub"
  resource_group_name  = azurerm_resource_group.vnet.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefix       = var.sub_ehub
}

resource "azurerm_subnet" "gateway" {
  name                 = "${var.project}-${var.environment}-${var.sub}-gateway"
  resource_group_name  = azurerm_resource_group.vnet.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefix       = var.sub_gateway
  #network_security_group_id = azurerm_network_security_group.gateway.id
}

resource "azurerm_subnet" "gateway_pri" {
  name                 = "${var.project}-${var.environment}-${var.sub}-gateway-pri"
  resource_group_name  = azurerm_resource_group.vnet.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefix       = var.sub_gateway_pri
  #network_security_group_id = azurerm_network_security_group.gateway_pri.id
}

resource "azurerm_subnet" "splunk" {
  name                 = "${var.project}-${var.environment}-${var.sub}-splunk"
  resource_group_name  = azurerm_resource_group.vnet.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefix       = var.sub_splunk
}

resource "azurerm_subnet" "vm" {
  name                 = "${var.project}-${var.environment}-${var.sub}-vm"
  resource_group_name  = azurerm_resource_group.vnet.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefix       = var.sub_vm
}

resource "azurerm_public_ip" "pri-Pip" {
  name                = "${var.project}-${var.environment}-${var.pip_private}"
  location            = var.region
  resource_group_name = azurerm_resource_group.vnet.name
  domain_name_label   = var.dns_label_pri
  allocation_method   = "Static"
  sku                 = "Standard"
  tags = {
    environment = var.environment
  }
}

resource "azurerm_public_ip" "pub-Pip" {
  name                = "${var.project}-${var.environment}-${var.pip_public}"
  location            = var.region
  resource_group_name = azurerm_resource_group.vnet.name
  domain_name_label   = var.dns_label_pub
  allocation_method   = "Static"
  sku                 = "Standard"
  tags = {
    environment = var.environment
  }
}

locals {
  backend_address_pool_name      = "${var.project}-${var.environment}-appgw-beap"
  frontend_port_name             = "${var.project}-${var.environment}-appgw-feport"
  frontend_ip_configuration_name = "${var.project}-${var.environment}-appgw-feip"
  http_setting_name              = "${var.project}-${var.environment}-appgw-be-htst"
  listener_name                  = "${var.project}-${var.environment}-appgw-httplstn"
  request_routing_rule_name      = "${var.project}-${var.environment}-appgw-rqrt"
  redirect_configuration_name    = "${var.project}-${var.environment}-appgw-rdrcfg"
  gateway_ip_configuration       = "${var.project}-${var.environment}-appgw-gwip"
  gateway_certificate_name       = "buyingcatalogue${var.environment}"
}

resource "azurerm_application_gateway" "pri-AppGate" {
  name                = "${var.project}-${var.environment}-${var.gw_private}"
  location            = var.region
  resource_group_name = azurerm_resource_group.vnet.name

  sku {
    name     = var.waf_name
    tier     = var.waf_tier
    capacity = var.waf_capacity
  }

  gateway_ip_configuration {
    name      = "${var.project}-gwip-pri"
    subnet_id = azurerm_subnet.gateway_pri.id
  }

  frontend_port {
    name = local.frontend_port_name
    port = 80
  }

  frontend_ip_configuration {
    name                 = local.frontend_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.pri-Pip.id
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

  waf_configuration {
    enabled                  = true
    file_upload_limit_mb     = 100
    firewall_mode            = "Prevention"
    max_request_body_size_kb = 128
    request_body_check       = true
    rule_set_type            = "OWASP"
    rule_set_version         = "3.1"

    disabled_rule_group {
      rule_group_name = "REQUEST-942-APPLICATION-ATTACK-SQLI"
      rules           = [
        942430,
        942130,
      ]
    }
  }

  lifecycle {
    # AGIC owns most app gateway settings, so we should ignore differences
    ignore_changes = [
      request_routing_rule, 
      http_listener, 
      backend_http_settings, 
      frontend_ip_configuration, 
      frontend_port,
      backend_address_pool,
      probe,
      ssl_certificate,
      url_path_map,
      redirect_configuration
    ]
  }
}

resource "azurerm_application_gateway" "pub-AppGate" {
  name                = "${var.project}-${var.environment}-${var.gw_public}"
  location            = var.region
  resource_group_name = azurerm_resource_group.vnet.name

  sku {
    name     = var.waf_name
    tier     = var.waf_tier
    capacity = var.waf_capacity
  }

  gateway_ip_configuration {
    name      = "${var.project}-gwip-pub"
    subnet_id = azurerm_subnet.gateway.id
  }

  frontend_port {
    name = local.frontend_port_name
    port = 80
  }

  frontend_ip_configuration {
    name                 = local.frontend_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.pub-Pip.id
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

  ssl_policy {
    policy_type = "Predefined"
    policy_name = "AppGwSslPolicy20170401S"
  }
  

  waf_configuration {
    enabled                  = true
    file_upload_limit_mb     = 100
    firewall_mode            = "Prevention"
    max_request_body_size_kb = 128
    request_body_check       = true
    rule_set_type            = "OWASP"
    rule_set_version         = "3.1"

    disabled_rule_group {
      rule_group_name = "REQUEST-942-APPLICATION-ATTACK-SQLI"
      rules           = [
        942430,
        942130,
      ]
    }
  }

  lifecycle {
    # AGIC owns most app gateway settings, so we should ignore differences
    ignore_changes = [
      request_routing_rule, 
      http_listener, 
      backend_http_settings, 
      frontend_ip_configuration, 
      frontend_port,
      backend_address_pool,
      probe,
      ssl_certificate,
      url_path_map,
      redirect_configuration
    ]
  }
}
