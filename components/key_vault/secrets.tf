# module "vm_linux_admin_password" {
#   source = "../../modules/keyvault_secret"

#   environment = "${var.environment}"
#   secret_name = "vm-linux-admin-password"
#   key_vault_id = "${azurerm_key_vault.keyvault.id}"
# }

# # Note this is not using the module as you need to specify the password somewhere.
# # DON'T specify the password here and check the damn thing in - read the readme.
# resource "azurerm_key_vault_secret" "ssl_password" {
#   name     = "ssl-password"
#   value    = "${var.passwordy_mcssl_passwordface}"
#   key_vault_id = "${azurerm_key_vault.keyvault.id}"

#   tags = {
#     environment = "${var.environment}"
#   }
# }