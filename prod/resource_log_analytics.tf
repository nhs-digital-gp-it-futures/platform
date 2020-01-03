resource "azurerm_resource_group" "log_analytics" {
  name                = "${var.project}-${var.environment}-rg-la"
  location            = "${var.region}"
  tags                = {
    environment       = "${var.environment}"
  }
}

resource "azurerm_log_analytics_workspace" "workspace" {
  name                = "${var.project}-${var.environment}-workspaces1"
  location            = "${var.region}"
  resource_group_name = "${azurerm_resource_group.log_analytics.name}"
  sku                 = "PerGB2018"
  retention_in_days   = 30
  tags                = {
    environment       = "${var.environment}"
  }
}