/*
    Place all SQL Databases in this file.
*/

resource "azurerm_sql_database" "sql" {
  name = "${var.project}-db-${var.environment}"
  resource_group_name = "${azurerm_resource_group.sql.name}"
  location = "${var.region}"
  server_name = "${azurerm_sql_server.sql.name}"
  collation = "SQL_Latin1_General_CP1_CI_AS"
}
