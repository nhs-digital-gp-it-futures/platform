resource "azurerm_key_vault" "keyvault" {
  name                        = "${var.project}-kv-${var.environment}"
  location                    = "${var.region}"
  resource_group_name         = "${azurerm_resource_group.keyvault.name}"
  enabled_for_disk_encryption = "true"
  tenant_id                   = "${var.tenant}"
  sku_name                    = "standard"

  

  tags = {
    environment = "${var.environment}"
  }
}