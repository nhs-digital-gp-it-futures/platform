resource "azurerm_resource_group" "storage" {
  name                              = "${var.project}-sa-${var.environment}"
  location                          = var.region
  tags                              = {
    environment                     = var.environment
  }
}

resource "azurerm_storage_account" "data" {
  name                              = "${var.project}sa${var.environment}"
  location                          = var.region
  resource_group_name               = azurerm_resource_group.storage.name
  account_tier                      = var.sa_tier
  account_replication_type          = var.sa_rep_type
  account_kind                      = var.sa_kind
  enable_advanced_threat_protection = "true"
  enable_https_traffic_only         = "true"
}

resource "azurerm_storage_account" "sqluks" {
  name                              = "${var.project}sasqluks${var.environment}"
  location                          = var.region
  resource_group_name               = azurerm_resource_group.storage.name
  account_tier                      = var.sa_tier
  account_replication_type          = var.sa_rep_type
  account_kind                      = var.sa_kind
  enable_advanced_threat_protection = "true"
  enable_https_traffic_only         = "true"
}

resource "azurerm_storage_account" "sqlukw" {
  name                              = "${var.project}sasqlukw${var.environment}"
  location                          = var.region1
  resource_group_name               = azurerm_resource_group.storage.name
  account_tier                      = var.sa_tier
  account_replication_type          = var.sa_rep_type
  account_kind                      = var.sa_kind
  enable_advanced_threat_protection = "true"
  enable_https_traffic_only         = "true"
}

resource "azurerm_storage_container" "data" {
  name                              = "$web"
  storage_account_name              = azurerm_storage_account.data.name
  container_access_type             = "container"
}

resource "azurerm_storage_container" "sqluks" {
  name                              = "sqlauditlogs"
  storage_account_name              = azurerm_storage_account.sqluks.name
  container_access_type             = "private"
}

resource "azurerm_storage_container" "sqlukw" {
  name                              = "sqlauditlogs"
  storage_account_name              = azurerm_storage_account.sqlukw.name
  container_access_type             = "private"
}