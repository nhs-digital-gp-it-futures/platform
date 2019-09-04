resource "azurerm_log_analytics_workspace" "workspace" {
  name                      = "${var.project}-workspace-${var.environment}"
  location                  = "${var.region}"
  resource_group_name       = "${azurerm_resource_group.log_analytics.name}"
  sku                       = "free"

  tags = {
    environment             = "${var.environment}"
  }
}