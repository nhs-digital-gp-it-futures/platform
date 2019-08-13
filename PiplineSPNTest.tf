resource "azurerm_resource_group" "ARG" {
  name = "AzTfGPITFutureRG"
  location = "uksouth"
}

resource "azurerm_virtual_network" "AVNET" {
  name = "AzTfGPITFutureVmet"
  location = "${azurerm_resource_group.ARG.location}"
  resource_group_name = "${azurerm_resource_group.ARG.name}"
  address_space = ["10.0.0.0/24"]
}

resource "azurerm_subnet" "AzTfGPITFutureSub" {
  name = "AzTfGPITFutureSub"
  resource_group_name = "${azurerm_resource_group.ARG.name}"
  virtual_network_name = "${azurerm_virtual_network.AVNET.name}"
  address_prefix = "10.0.0.0/27"
}
