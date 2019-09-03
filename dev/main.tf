/*
    Place all resource groups for Azure Storage Accounts in this file.
*/
resource "azurerm_resource_group" "keyvault" {
  name     = "${var.project}-kv-${var.environment}"
  location = "${var.region}"

  tags = {
    environment = "${var.environment}"
  }
}

resource "azurerm_resource_group" "aks" {
  name     = "${var.project}-aks-${var.environment}"
  location = "${var.region}"

  tags = {
    environment = "${var.environment}"
  }
}

resource "azurerm_resource_group" "log_analytics" {
  name     = "${var.project}-loganalytics-${var.environment}"
  location = "${var.region}"

  tags = {
    environment = "${var.environment}"
  }
}

resource "azurerm_resource_group" "sql" {
  name     = "${var.project}-sql-${var.environment}"
  location = "${var.region}"

  tags = {
    environment = "${var.environment}"
  }
}

resource "azurerm_resource_group" "storage" {
  name     = "${var.project}-sa-${var.environment}"
  location = "${var.region}"

  tags = {
    environment = "${var.environment}"
  }
}

resource "azurerm_resource_group" "virtual_machine" {
  name     = "${var.project}-vm-${var.environment}"
  location = "${var.region}"

  tags = {
    environment = "${var.environment}"
  }
}

resource "azurerm_resource_group" "virtual_network" {
  name     = "${var.project}-vnet-${var.environment}"
  location = "${var.region}"

  tags = {
    environment = "${var.environment}"
  }
}