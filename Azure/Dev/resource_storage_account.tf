resource "azurerm_resource_group" "storage" {
  name     = "${var.project}-${var.environment}-rg-sa"
  location = var.region
  tags = {
    environment = var.environment
  }
}

resource "azurerm_storage_account" "data" {
  name                      = "${var.project}${var.environment}sa"
  location                  = var.region
  resource_group_name       = azurerm_resource_group.storage.name
  account_tier              = var.sa_tier
  account_replication_type  = var.sa_rep_type
  account_kind              = var.sa_kind
  enable_https_traffic_only = "true"
  tags                      = {
    "ms-resource-usage" = "azure-cloud-shell"
  }
}

resource "azurerm_advanced_threat_protection" "data" {
  target_resource_id = azurerm_storage_account.data.id
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

resource "azurerm_storage_container" "data" {
  name                  = "$web"
  storage_account_name  = azurerm_storage_account.data.name
  container_access_type = "blob"
}

resource "azurerm_storage_container" "documents" {
  name                  = "documents"
  storage_account_name  = azurerm_storage_account.data.name
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


resource "azurerm_storage_account" "helm" {
  name                      = "${var.project}${var.environment}helm"
  location                  = var.region
  resource_group_name       = azurerm_resource_group.storage.name
  account_tier              = var.sa_tier
  account_replication_type  = var.sa_rep_type
  account_kind              = var.sa_kind
  enable_https_traffic_only = "true"
  tags                      = {
    "ms-resource-usage" = "azure-cloud-shell"
  }
}

resource "azurerm_advanced_threat_protection" "helm" {
  target_resource_id = azurerm_storage_account.helm.id
  enabled            = true
}

resource "azurerm_storage_container" "helm" {
  name                  = "helm"
  storage_account_name  = azurerm_storage_account.helm.name
  container_access_type = "container"
}