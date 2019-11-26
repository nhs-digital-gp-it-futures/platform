resource "azurerm_resource_group" "log_analytics" {
  name     = "${var.project}-loganalytics-${var.environment}"
  location = var.region

  tags = {
    environment = var.environment
  }
}

resource "azurerm_management_lock" "log_analytics" {
  name       = "CanNotDelete"
  scope      = azurerm_resource_group.log_analytics.id
  lock_level = "CanNotDelete"
  notes      = "Azure Lock for Dev Log Analytics"
}

resource "azurerm_log_analytics_workspace" "workspace" {
  name                = "${var.project}-workspace-${var.environment}"
  location            = var.region
  resource_group_name = azurerm_resource_group.log_analytics.name
  sku                 = "PerGB2018"
  retention_in_days   = 30

  tags = {
    environment = var.environment
  }
}

