resource "azurerm_resource_group" "ehubuks" {
  name                = "${var.project}-${var.environment}-rg-ehub-uks"
  location            = var.region
}

resource "azurerm_eventhub_namespace" "ehubuks" {
  name                = "${var.project}-${var.environment}-ensuks"
  resource_group_name = azurerm_resource_group.ehubuks.name
  location            = var.region
  sku                 = "Standard"
  capacity            = "2"
  tags                = {
    environment       = var.environment
  }
}

resource "azurerm_eventhub" "ehubuks" {
  name                = "${var.project}-${var.environment}-ehubuks"
  namespace_name      = azurerm_eventhub_namespace.ehubuks.name
  resource_group_name = azurerm_resource_group.ehubuks.name
  partition_count     = "2"
  message_retention   = "1"
}
