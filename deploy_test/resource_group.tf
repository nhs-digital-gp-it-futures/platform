# Create root level resources here...
resource "azurerm_resource_group" "keyvault" {
  name     = "${var.project}-keyvault-${var.environment}"
  location = "${var.region}"

  tags = {
    environment = "${var.environment}"
  }
}

/*
    Place all resource groups for the aks cluster in this file.
*/
resource "azurerm_resource_group" "aks" {
  name     = "${var.project}-aks-${var.environment}"
  location = "${var.region}"

  tags = {
    environment = "var.environment"
  }
}

/*
    Place all resource groups for Azure SQL in this file.
*/

resource "azurerm_resource_group" "sql" {
  name     = "${var.project}-sql-${var.environment}"
  location = "${var.region}"

  tags = {
    environment = "var.environment"
  }
}

/*
    Place all resource groups for Azure Storage Accounts in this file.
*/
resource "azurerm_resource_group" "storage" {
  name     = "${var.project}-sa-${var.environment}"
  location = "${var.region}"

  tags = {
    environment = "${var.environment}"
  }
}

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