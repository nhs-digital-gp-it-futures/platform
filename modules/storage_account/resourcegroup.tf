/*
    Place all resource groups for Azure Storage Accounts in this file.
*/
resource "azurerm_resource_group" "storage" {
  name     = "${var.project}-sa-${var.environment}"
  location = "${var.region}"

  tags = {
    environment = "${var.environment}"
  }
}