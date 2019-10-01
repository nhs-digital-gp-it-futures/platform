resource "azurerm_resource_group" "storage" {
  name                      = "${var.project}-sa-${var.environment}"
  location                  = "${var.region}"
  tags = {
    environment             = "${var.environment}"
  }
}

resource "azurerm_storage_account" "data" {
  name                      = "${var.project}sa${var.environment}"
  location                  = "${var.region}"
  resource_group_name       = "${azurerm_resource_group.storage.name}"
  account_tier              = "${var.sa_tier}"
  account_replication_type  = "${var.sa_rep_type}"
  account_kind              = "${var.sa_kind}"
enable_https_traffic_only   = "true"
}

resource "azurerm_storage_account" "sql" {
  name                      = "${var.project}sasql${var.environment}"
  location                  = "${var.region}"
  resource_group_name       = "${azurerm_resource_group.storage.name}"
  account_tier              = "${var.sa_tier}"
  account_replication_type  = "${var.sa_rep_type}"
  account_kind              = "${var.sa_kind}"
enable_https_traffic_only   = "true"
}

resource "azurerm_storage_container" "data" {
  name                      = "data"
  storage_account_name      = "${azurerm_storage_account.data.name}"
  container_access_type     = "private"
}