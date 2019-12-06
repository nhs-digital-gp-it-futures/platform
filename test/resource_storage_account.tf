resource "azurerm_resource_group" "storage" {
  name                              = "${var.project}-${var.environment}-rg-sa"
  location                          = "${var.region}"
  tags                              = {
    environment                     = "${var.environment}"
  }
}

resource "azurerm_management_lock" "storage" {
  name                              = "lock_storage_account"
  scope                             = "/subscriptions/7b12a8a2-f06f-456f-b6f9-aa2d92e0b2ec/resourceGroups/gpitfutures-test-rg-sa"
  lock_level                        = "CanNotDelete"
  notes                             = "This resource group has been set to DoNotDelete to prevent terraform tfstate files and static content from being deleted"
}

resource "azurerm_storage_account" "data" {
  name                              = "${var.project}${var.environment}sa"
  location                          = "${var.region}"
  resource_group_name               = "${azurerm_resource_group.storage.name}"
  account_tier                      = "${var.sa_tier}"
  account_replication_type          = "${var.sa_rep_type}"
  account_kind                      = "${var.sa_kind}"
  enable_advanced_threat_protection = "true"
  enable_https_traffic_only         = "true"
}

resource "azurerm_storage_account" "sqluks" {
  name                              = "${var.project}${var.environment}sasqluks"
  location                          = "${var.region}"
  resource_group_name               = "${azurerm_resource_group.storage.name}"
  account_tier                      = "${var.sa_tier}"
  account_replication_type          = "${var.sa_rep_type}"
  account_kind                      = "${var.sa_kind}"
  enable_advanced_threat_protection = "true"
  enable_https_traffic_only         = "true"
}

resource "azurerm_storage_account" "sqlukw" {
  name                              = "${var.project}${var.environment}sasqlukw"
  location                          = "${var.region1}"
  resource_group_name               = "${azurerm_resource_group.storage.name}"
  account_tier                      = "${var.sa_tier}"
  account_replication_type          = "${var.sa_rep_type}"
  account_kind                      = "${var.sa_kind}"
  enable_advanced_threat_protection = "true"
  enable_https_traffic_only         = "true"
}

resource "azurerm_storage_container" "data" {
  name                  = "$web"
  storage_account_name  = "${azurerm_storage_account.data.name}"
  container_access_type = "blob"
}

resource "azurerm_storage_container" "sqluks" {
  name                  = "sqlauditlogs"
  storage_account_name  = "${azurerm_storage_account.sqluks.name}"
  container_access_type = "private"
}

resource "azurerm_storage_container" "sqlukw" {
  name                  = "sqlauditlogs"
  storage_account_name  = "${azurerm_storage_account.sqlukw.name}"
  container_access_type = "private"
}