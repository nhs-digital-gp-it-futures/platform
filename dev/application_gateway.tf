/*
    Configuration for the NSG

    [--sku {Standard_Large, Standard_Medium, Standard_Small, Standard_v2, WAF_Large, WAF_Medium, WAF_v2}]
*/

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
    name                    = "${var.project}-appgw-${var.environment}"
    location                = "${var.region}"
    resource_group_name     = "${azurerm_virtual_network.vnet.name}"

    sku {
    name                    = "WAF_Medium"
    tier                    = "WAF"
    capacity                = 2

    }
    
    gateway_ip_configuration {
    name                    = "${var.project}-gwip"
    subnet_id               = "${azurerm_subnet.gateway.id}"
    }
 
    frontend_port {
    name                    = "${local.frontend_port_name}"
    port                    = 80
    }

      frontend_ip_configuration {
    name                 = "${local.frontend_ip_configuration_name}"
    public_ip_address_id = "${azurerm_public_ip.Pip.id}"
  }

    backend_address_pool {
    name = "${local.backend_address_pool_name}"
  }

    backend_http_settings {
    name                  = "${local.http_setting_name}"
    cookie_based_affinity = "Disabled"
    path                  = "/path/"
    port                  = 443
    protocol              = "Https"
    request_timeout       = 1
    }

    http_listener {
    name                           = "${local.listener_name}"
    frontend_ip_configuration_name = "${local.frontend_ip_configuration_name}"
    frontend_port_name             = "${local.frontend_port_name}"
    protocol                       = "Http"
    }

    request_routing_rule {
    name                       = "${local.request_routing_rule_name}"
    rule_type                  = "Basic"
    http_listener_name         = "${local.listener_name}"
    backend_address_pool_name  = "${local.backend_address_pool_name}"
    backend_http_settings_name = "${local.http_setting_name}"
    }
}