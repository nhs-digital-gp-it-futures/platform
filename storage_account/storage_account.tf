/*
    Place all storage accounts in this file.
    ${var.project}sa${var.environment}
*/
resource "azurerm_storage_account" "storage" {
  name                      = "${var.project}sa${var.environment}"
  location                  = "${var.region}"
  resource_group_name       = "${azurerm_resource_group.storage.name}"
  account_tier              = "standard"
  account_replication_type  = "grs"
  account_kind              = "StorageV2"
enable_https_traffic_only   = "true"
}


resource "azurerm_storage_account" "SQL" {
  name                      = "${var.project}sasql${var.environment}"
  location                  = "${var.region}"
  resource_group_name       = "${azurerm_resource_group.storage.name}"
  account_tier              = "standard"
  account_replication_type  = "grs"
  account_kind              = "StorageV2"
enable_https_traffic_only   = "true"
}