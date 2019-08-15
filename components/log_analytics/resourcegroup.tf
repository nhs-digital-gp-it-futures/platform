/*
    Place all resource groups for Azure SQL in this file.
*/
resource "azurerm_resource_group" "oms" {
  name     = "${var.project}-sql-${var.environment}"
  location = "${var.region}"

  tags = {
    environment = "${var.environment}"
  }
}