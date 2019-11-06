resource "azurerm_resource_group" "log_analytics" {
  name                                  = "${var.project}-loganalytics-${var.environment}"
  location                              = "${var.region}"

  tags                                  = {
    environment                         = "${var.environment}"
  }
}

resource "azurerm_log_analytics_workspace" "workspace" {
  name                                  = "${var.project}-workspace-${var.environment}"
  location                              = "${var.region}"
  resource_group_name                   = "${azurerm_resource_group.log_analytics.name}"
  sku                                   = "PerGB2018"
  retention_in_days                     = 30

  tags = {
    environment                         = "${var.environment}"
  }
}

resource "azurerm_log_analytics_solution" "workspace" {
  solution_name                         = "${var.project}-akslogs-${var.environment}"
  location                              = "${var.region}"
  resource_group_name                   = "${azurerm_resource_group.log_analytics.name}"
  workspace_name                        = "${azurerm_log_analytics_workspace.workspace.name}"
  workspace_resource_id                 = "${azurerm_log_analytics_workspace.workspace.id}"

  plan {
    publisher                           = "Microsoft"
    product                             = "OMSGallery/ContainerInsights"
  }
}

