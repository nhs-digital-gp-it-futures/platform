resource "azurerm_resource_group" "ehubuks" {
    name                                    = "${var.project}-ehubuks-${var.environment}"
    location                                = "${var.region}"
  
}

resource "azurerm_resource_group" "ehubukw" {
    name                                    = "${var.project}-ehubukw-${var.environment}"
    location                                = "${var.region1}"
  
}

resource "azurerm_eventhub_namespace" "ehubuks" {
    name                                    = "${var.project}-ensuks-${var.environment}"
    resource_group_name                     = "${azurerm_resource_group.ehubuks.name}"
    location                                = "${var.region}"
    sku                                     = "Standard"
    capacity                                = "2"
    kafka_enabled                           = "true"
    tags                                    = {

        environment                         = "${var.environment}"

  }

}

resource "azurerm_eventhub_namespace" "ehubukw" {
    name                                    = "${var.project}-ensukw-${var.environment}"
    resource_group_name                     = "${azurerm_resource_group.ehubukw.name}"
    location                                = "${var.region1}"
    sku                                     = "Standard"
    capacity                                = "2"
    kafka_enabled                           = "true"
    tags                                    = {

        environment                         = "${var.environment}"

  }

}


resource "azurerm_eventhub" "ehubuks" {
  name                                      = "${var.project}-ehubuks-${var.environment}"
  namespace_name                            = "${azurerm_eventhub_namespace.ehubuks.name}"
  resource_group_name                       = "${azurerm_resource_group.ehubuks.name}"
  partition_count                           = "2"
  message_retention                         = "1"

}

resource "azurerm_eventhub" "ehubukw" {
  name                                      = "${var.project}-ehubukw-${var.environment}"
  namespace_name                            = "${azurerm_eventhub_namespace.ehubukw.name}"
  resource_group_name                       = "${azurerm_resource_group.ehubukw.name}"
  partition_count                           = "2"
  message_retention                         = "1"

}