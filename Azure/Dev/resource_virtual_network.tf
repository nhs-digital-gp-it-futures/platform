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
  gateway_certificate_key_vault_secret_id = "https://${var.project}-${var.environment}-kv.vault.azure.net/secrets/buyingcatalogue${var.environment}"
}

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
  address_prefixes       = [var.sub_aks]
}

resource "azurerm_subnet" "ehub" {
  name                 = "${var.project}-${var.environment}-${var.sub}-ehub"
  resource_group_name  = azurerm_resource_group.vnet.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes       = [var.sub_ehub]
}

resource "azurerm_subnet" "gateway" {
  name                 = "${var.project}-${var.environment}-${var.sub}-gateway"
  resource_group_name  = azurerm_resource_group.vnet.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes       = [var.sub_gateway]
}

resource "azurerm_subnet" "splunk" {
  name                 = "${var.project}-${var.environment}-${var.sub}-splunk"
  resource_group_name  = azurerm_resource_group.vnet.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes       = [var.sub_splunk]
}

resource "azurerm_subnet" "vm" {
  name                 = "${var.project}-${var.environment}-${var.sub}-vm"
  resource_group_name  = azurerm_resource_group.vnet.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes       = [var.sub_vm]
}

resource "azurerm_public_ip" "Pip" {
  name                = "${var.project}-${var.environment}-pip"
  location            = var.region
  domain_name_label   = var.dns_label
  resource_group_name = azurerm_resource_group.vnet.name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags = {
    environment = var.environment
  }
}

resource "azurerm_application_gateway" "AppGate" {
  name                = "${var.project}-${var.environment}-appgw"
  location            = var.region
  resource_group_name = azurerm_resource_group.vnet.name

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

  ssl_policy {
    policy_type = "Predefined"
    policy_name = "AppGwSslPolicy20170401S"
  }
  
  # Issue https://github.com/terraform-providers/terraform-provider-azurerm/issues/4408 - fixed but not resolved
  # Issue https://github.com/terraform-providers/terraform-provider-azurerm/issues/6188 - can't set unversioned secret id
  # ssl_certificate {
  #   name = local.gateway_certificate_name
  #   key_vault_secret_id = local.gateway_certificate_key_vault_secret_id   
  # }

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
        942450,
        942440,
        942210,
        942380 
      ]
    }
    disabled_rule_group {
      rule_group_name = "REQUEST-920-PROTOCOL-ENFORCEMENT"
      rules           = [ 920230 ]
    }
    disabled_rule_group {
      rule_group_name = "REQUEST-931-APPLICATION-ATTACK-RFI"
      rules           = [ 931130 ]
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
      redirect_configuration,      
      url_path_map,     
      tags, # AGIC adds tags which need to be ignored. Can't seem to ignore the individual tags
      ssl_certificate # see issue above
      #waf_configuration.0 # see issue above
    ]
  }
}
