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
    retention_days = "90"
    storage_endpoint = "https://gpitfutresadev.blob.core.windows.net/sqlauditlogs"
    storage_account_access_key = "gq7aSMEQBcZx3c87FNQ4rTIKH92N0MTMelJO3yNytmaQPlI25ay3/13WU8X9LMvh1PeONq92BCiHmqyT1RBu9Q=="

  }
  
}
