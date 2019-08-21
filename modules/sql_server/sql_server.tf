/*
    Place all SQL Server details within in this file.
*/

resource "azurerm_sql_server" "sql" {

  name                          = "${var.project}-sql-${var.environment}"
  resource_group_name           = "${azurerm_resource_group.sql.name}"
  location                      = "${var.region}"
  version                       = "12.0"
  administrator_login           = "gpitfutureadmin"
  administrator_login_password  = "MAhdzDHYb*Hy&hQqAmwg3ujmU"

}

resource "azurerm_sql_firewall_rule" "sql" {
  name = "azure_services"
  resource_group_name = "${azurerm_resource_group.sql.name}"
  server_name = "${azurerm_sql_server.sql.name}"
  start_ip_address = "0.0.0.0"
  end_ip_address = "0.0.0.0"
  
}
