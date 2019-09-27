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
  version                           = "12.0"
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
  name                              = "gpitfuturebcteam"
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
  collation                         = "SQL_Latin1_General_CP1_CI_AS"
  edition                           = "Standard"
  requested_service_objective_name  = "S1"
  threat_detection_policy {
    state                           = "enabled"
    storage_endpoint                = "${azurerm_storage_account.sql.primary_blob_endpoint}"
    storage_account_access_key      = "${azurerm_storage_account.sql.primary_access_key}"

  }
}

resource "azurerm_sql_database" "bc-sql1" {
  name                              = "${var.project}-db01-${var.environment}"
  resource_group_name               = "${azurerm_resource_group.bc-sql.name}"
  location                          = "${var.region}"
  server_name                       = "${azurerm_sql_server.bc-sql.name}"
  collation                         = "SQL_Latin1_General_CP1_CI_AS"
  edition                           = "Standard"
  requested_service_objective_name  = "S1"
  threat_detection_policy {
    state                           = "enabled"
    storage_endpoint                = "${azurerm_storage_account.sql.primary_blob_endpoint}"
    storage_account_access_key      = "${azurerm_storage_account.sql.primary_access_key}"

  }
}
