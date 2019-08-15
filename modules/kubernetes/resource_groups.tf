/*
    Place all resource groups for the aks cluster in this file.
*/
resource "azurerm_resource_group" "aks" {
  name     = "${var.project}-aks-${var.environment}"
  location = "${var.region}"

  tags = {
    environment = "${var.environment}"
  }
}