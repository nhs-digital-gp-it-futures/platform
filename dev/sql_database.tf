/*
    Place all SQL Databases in this file.
*/

resource "azurerm_sql_database" "sql" {
  name = "${var.project}-db-${var.environment}"
  resource_group_name = "${azurerm_resource_group.sql.name}"
  location = "${var.region}"
  server_name = "${azurerm_sql_server.sql.name}"
  collation = "SQL_Latin1_General_CP1_CI_AS"

  threat_detection_policy {
    state = "Enabled"
    retention_days = "35"
    storage_endpoint = "https://gpitfutresasqldev.blob.core.windows.net/"
    storage_account_access_key = "yRYQETLQ0xN35FOvsOgV0M8EF0zANpyq0CDy/yUcLBbFrU/M23KWU7gttFmJCHyj+XQE/KgBkauZuzevJ9NIxQ=="

  }

}
