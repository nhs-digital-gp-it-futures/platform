resource "azurerm_resource_group" "bc-sql-pri" {
  name                              = "${var.project}-${var.environment}-rg-sql-pri"
  location                          = "${var.region}"
  tags                              = {
    environment                     = "${var.environment}"
  }
}

resource "azurerm_resource_group" "bc-sql-sec" {
  name                              = "${var.project}-${var.environment}-rg-sql-sec"
  location                          = "${var.region1}"
  tags                              = {
    environment                     = "${var.environment}"
  }
}

resource "azurerm_sql_server" "bc-sql-pri" {
  name                              = "${var.project}-${var.environment}-sql-pri"
  resource_group_name               = "${azurerm_resource_group.bc-sql-pri.name}"
  location                          = "${var.region}"
  version                           = "${var.sql_version}"
  administrator_login               = "${data.azurerm_key_vault_secret.kv-sqluser.value}"
  administrator_login_password      = "${data.azurerm_key_vault_secret.kv-sqlpass.value}"
}

resource "azurerm_sql_server" "bc-sql-sec" {
  name                              = "${var.project}-${var.environment}-sql-sec"
  resource_group_name               = "${azurerm_resource_group.bc-sql-sec.name}"
  location                          = "${var.region1}"
  version                           = "${var.sql_version}"
  administrator_login               = "${data.azurerm_key_vault_secret.kv-sqluser.value}"
  administrator_login_password      = "${data.azurerm_key_vault_secret.kv-sqlpass.value}"
}

resource "azurerm_sql_firewall_rule" "bc-sql-pri" {
  name                              = "azure_services"
  resource_group_name               = "${azurerm_resource_group.bc-sql-pri.name}"
  server_name                       = "${azurerm_sql_server.bc-sql-pri.name}"
  start_ip_address                  = "0.0.0.0"
  end_ip_address                    = "0.0.0.0"
}

resource "azurerm_sql_firewall_rule" "bc-sql-sec" {
  name                              = "azure_services"
  resource_group_name               = "${azurerm_resource_group.bc-sql-sec.name}"
  server_name                       = "${azurerm_sql_server.bc-sql-sec.name}"
  start_ip_address                  = "0.0.0.0"
  end_ip_address                    = "0.0.0.0"
}

resource "azurerm_sql_database" "bc-sql" {
  name                              = "${var.project}-${var.environment}-db"
  resource_group_name               = "${azurerm_resource_group.bc-sql-pri.name}"
  location                          = "${var.region}"
  server_name                       = "${azurerm_sql_server.bc-sql-pri.name}"
  collation                         = "${var.sql_collation}"
  edition                           = "${var.sql_edition}"
  requested_service_objective_name  = "${var.sql_size}"
}

resource "azurerm_sql_failover_group" "bc-sql" {
  name                              = "${var.project}-${var.environment}-sql-fog"
  resource_group_name               = "${azurerm_resource_group.bc-sql-pri.name}"
  server_name                       = "${azurerm_sql_server.bc-sql-pri.name}"
  databases                         = ["${azurerm_sql_database.bc-sql.id}"]
  partner_servers {
    id                              = "${azurerm_sql_server.bc-sql-sec.id}"
  }
  read_write_endpoint_failover_policy {
    mode                            = "Automatic"
    grace_minutes                   = 30
  }
}