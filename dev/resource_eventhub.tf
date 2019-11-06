resource "azurerm_resource_group" "ehub" {
    name                                    = "${var.project}-ehub-${var.environment}"
    location                                = "${var.region}"
  
}

resource "azurerm_eventhub_namespace" "ehub" {
    name                                    = "${var.project}-ens-${var.environment}"
    resource_group_name                     = "${azurerm_resource_group.ehub.name}"
    location                                = "${var.region}"
    sku                                     = "Standard"
    capacity                                = "2"
    kafka_enabled                           = "true"
    tags                                    = {

        environment                         = "dev"

  }

}


resource "azurerm_eventhub" "ehub" {
  name                                      = "${var.project}-ehub-${var.environment}"
  namespace_name                            = "${azurerm_eventhub_namespace.ehub.name}"
  resource_group_name                       = "${azurerm_resource_group.ehub.name}"
  partition_count                           = "2"
  message_retention                         = "1"


}