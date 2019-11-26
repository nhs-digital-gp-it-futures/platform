resource "azurerm_public_ip" "Pip1" {
  name                = "${var.project}-pip1-${var.environment}1"
  location            = var.region
  resource_group_name = "gpitfuture-akspool-dev"
  allocation_method   = "Static"
  sku                 = "Standard"
  tags = {
    environment = var.environment
  }
}

