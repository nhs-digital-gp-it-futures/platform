resource "azurerm_application_gateway" "AppGate" {
    name                    = "${var.project}-vnet-${var.environment}"
    location                = "${var.region}"
    resource_group_name     = "${azurerm_resource_group.vnet}"

    sku {
    name                    = "Standard_Small"
    tier                    = "Standard"
    capacity                = 2

    }
    
    gateway_ip_configuration {
    name                    = "my-gateway-ip-configuration"
    subnet_id               = "${azurerm_subnet.frontend.id}"
    }

    frontend_port {
    name                    = "${local.frontend_port_name}"
    port                    = 80
    }

    backend_address_pool {
    name                 = "${local.frontend_ip_configuration_name}"
    public_ip_address_id = "${azurerm_public_ip.test.id}"
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