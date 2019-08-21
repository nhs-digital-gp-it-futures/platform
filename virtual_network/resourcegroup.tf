# Azure Provider

provider "azurerm" {
  version = "1.32.1"
}

/*
    Place all resource groups for VNets in this file.
*/
resource "azurerm_resource_group" "vnet" {
  name     = "${var.project}-vnet-${var.environment}"
  location = "${var.region}"

  tags = {
    environment = "${var.environment}"
  }
}