terraform {

required_version = ">= 0.11"

backend "azurerm" {

storage_account_name = "__terraformstorageaccount__"

container_name       = "terraform"

key                  = "terraform.tfstate"

access_key           = "__storagekey__"

}

}




resource "azurerm_resource_group" "rg" {

name     = "__resource_group__"

location = "__location__"

}




resource "azurerm_virtual_network" "vnet" {

name                = "${var.virtual_network_name}"

location            = "__location__"

address_space       = ["${var.address_space}"]

resource_group_name = "${azurerm_resource_group.rg.name}"

}




resource "azurerm_subnet" "subnetfrontend" {

name                 = "${var.subnetname_prefixfrontend}"

virtual_network_name = "${azurerm_virtual_network.vnet.name}"

resource_group_name  = "${azurerm_resource_group.rg.name}"

address_prefix       = "${var.subnet_prefixfrontend}"

}




resource "azurerm_subnet" "subnetbackend" {

name                 = "${var.subnetname_prefixbackend}"

virtual_network_name = "${azurerm_virtual_network.vnet.name}"

resource_group_name  = "${azurerm_resource_group.rg.name}"

address_prefix       = "${var.subnet_prefixbackend}"

}