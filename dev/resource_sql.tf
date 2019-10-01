resource "azurerm_resource_group" "bc-sql" {
  name                              = "${var.project}-sql-${var.environment}"
  location                          = "${var.region}"

  tags                              = {
    environment                     = "${var.environment}"
  }
}

resource "azurerm_sql_server" "bc-sql" {

  name                              = "${var.project}-sql-${var.environment}"
  resource_group_name               = "${azurerm_resource_group.bc-sql.name}"
  location                          = "${var.region}"
  version                           = "${var.sql_version}"
  administrator_login               = "${data.azurerm_key_vault_secret.kv-sqluser.value}"
  administrator_login_password      = "${data.azurerm_key_vault_secret.kv-sqlpass.value}"

}

resource "azurerm_sql_firewall_rule" "bc-sql" {
  name                              = "azure_services"
  resource_group_name               = "${azurerm_resource_group.bc-sql.name}"
  server_name                       = "${azurerm_sql_server.bc-sql.name}"
  start_ip_address                  = "0.0.0.0"
  end_ip_address                    = "0.0.0.0"
  
}

resource "azurerm_sql_firewall_rule" "bc-sql1" {
  name                              = "${var.project}bcteam"
  resource_group_name               = "${azurerm_resource_group.bc-sql.name}"
  server_name                       = "${azurerm_sql_server.bc-sql.name}"
  start_ip_address                  = "167.98.146.253"
  end_ip_address                    = "167.98.146.253"
  
}
resource "azurerm_sql_database" "bc-sql" {
  name                              = "${var.project}-db-${var.environment}"
  resource_group_name               = "${azurerm_resource_group.bc-sql.name}"
  location                          = "${var.region}"
  server_name                       = "${azurerm_sql_server.bc-sql.name}"
  collation                         = "${var.sql_collation}"
  edition                           = "${var.sql_edition}"
  requested_service_objective_name  = "${var.sql_size}"

  threat_detection_policy {
    state                           = "enabled"
    storage_endpoint                = "${azurerm_storage_account.sql.primary_blob_endpoint}"
    storage_account_access_key      = "${azurerm_storage_account.sql.primary_access_key}"
    retention_days                  = "${var.sql_retention}"
  }
}