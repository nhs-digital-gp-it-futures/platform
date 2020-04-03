resource "azurerm_resource_group" "storage" {
  name     = "${var.project}-${var.environment}-rg-sa"
  location = var.region
  tags = {
    environment = var.environment
  }
}

resource "azurerm_storage_account" "private" {
  name                      = "${var.project}${var.environment}sapri"
  location                  = var.region
  resource_group_name       = azurerm_resource_group.storage.name
  account_tier              = var.sa_tier
  account_replication_type  = var.sa_rep_type
  account_kind              = var.sa_kind
  enable_https_traffic_only = "true"
}

resource "azurerm_advanced_threat_protection" "private" {
  target_resource_id = azurerm_storage_account.private.id
  enabled            = true
}

resource "azurerm_storage_account" "public" {
  name                      = "${var.project}${var.environment}sapub"
  location                  = var.region
  resource_group_name       = azurerm_resource_group.storage.name
  account_tier              = var.sa_tier
  account_replication_type  = var.sa_rep_type
  account_kind              = var.sa_kind
  enable_https_traffic_only = "true"
}

resource "azurerm_advanced_threat_protection" "public" {
  target_resource_id = azurerm_storage_account.public.id
  enabled            = true
}

resource "azurerm_storage_account" "sqluks" {
  name                      = "${var.project}${var.environment}sasqluks"
  location                  = var.region
  resource_group_name       = azurerm_resource_group.storage.name
  account_tier              = var.sa_tier
  account_replication_type  = var.sa_rep_type
  account_kind              = var.sa_kind
  enable_https_traffic_only = "true"
}

resource "azurerm_advanced_threat_protection" "sqluks" {
  target_resource_id = azurerm_storage_account.sqluks.id
  enabled            = true
}

resource "azurerm_storage_account" "sqlukw" {
  name                      = "${var.project}${var.environment}sasqlukw"
  location                  = var.region1
  resource_group_name       = azurerm_resource_group.storage.name
  account_tier              = var.sa_tier
  account_replication_type  = var.sa_rep_type
  account_kind              = var.sa_kind
  enable_https_traffic_only = "true"
}

resource "azurerm_advanced_threat_protection" "sqlukw" {
  target_resource_id = azurerm_storage_account.sqlukw.id
  enabled            = true
}

resource "azurerm_storage_container" "pri-web" {
  name                  = "$web"
  storage_account_name  = azurerm_storage_account.private.name
  container_access_type = "blob"
}

resource "azurerm_storage_container" "pri-documents" {
  name                  = "documents"
  storage_account_name  = azurerm_storage_account.private.name
  container_access_type = "blob"
}

resource "azurerm_storage_container" "pub-web" {
  name                  = "$web"
  storage_account_name  = azurerm_storage_account.public.name
  container_access_type = "blob"
}

resource "azurerm_storage_container" "pub-documents" {
  name                  = "documents"
  storage_account_name  = azurerm_storage_account.public.name
  container_access_type = "blob"
}

resource "azurerm_storage_container" "sqluks" {
  name                  = "sqlauditlogs"
  storage_account_name  = azurerm_storage_account.sqluks.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "sqlukw" {
  name                  = "sqlauditlogs"
  storage_account_name  = azurerm_storage_account.sqlukw.name
  container_access_type = "private"
}
