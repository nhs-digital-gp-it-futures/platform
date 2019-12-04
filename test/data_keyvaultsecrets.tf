#Key vault is created using Terraform. Terraform script isn't stored in the github respository due to this being public.
#Key vault Terraform will be stored in the AzureDevOps repo.

data "azurerm_key_vault_secret" "kv-tenant" {
  name         = "gpittesttenantid"
  key_vault_id = "/subscriptions/7b12a8a2-f06f-456f-b6f9-aa2d92e0b2ec/resourceGroups/gpitfutures-kv-test/providers/Microsoft.KeyVault/vaults/gpitfutures-kv-test"
}

data "azurerm_key_vault_secret" "kv-subscription" {
  name         = "gpittestsubscriptionid"
  key_vault_id = "/subscriptions/7b12a8a2-f06f-456f-b6f9-aa2d92e0b2ec/resourceGroups/gpitfutures-kv-test/providers/Microsoft.KeyVault/vaults/gpitfutures-kv-test"
}

data "azurerm_key_vault_secret" "kv-spn" {
  name         = "gpittestserviceprincipalnameid"
  key_vault_id = "/subscriptions/7b12a8a2-f06f-456f-b6f9-aa2d92e0b2ec/resourceGroups/gpitfutures-kv-test/providers/Microsoft.KeyVault/vaults/gpitfutures-kv-test"
}

data "azurerm_key_vault_secret" "kv-appid" {
  name         = "gpittestapplicationid"
  key_vault_id = "/subscriptions/7b12a8a2-f06f-456f-b6f9-aa2d92e0b2ec/resourceGroups/gpitfutures-kv-test/providers/Microsoft.KeyVault/vaults/gpitfutures-kv-test"
}

data "azurerm_key_vault_secret" "kv-objectid" {
  name         = "gpittestobjectid"
  key_vault_id = "/subscriptions/7b12a8a2-f06f-456f-b6f9-aa2d92e0b2ec/resourceGroups/gpitfutures-kv-test/providers/Microsoft.KeyVault/vaults/gpitfutures-kv-test"
}

data "azurerm_key_vault_secret" "kv-secret" {
  name         = "gpittestclientsecretkeyid"
  key_vault_id = "/subscriptions/7b12a8a2-f06f-456f-b6f9-aa2d92e0b2ec/resourceGroups/gpitfutures-kv-test/providers/Microsoft.KeyVault/vaults/gpitfutures-kv-test"
}

data "azurerm_key_vault_secret" "kv-buser" {
  name         = "gpittestbastionadminusername"
  key_vault_id = "/subscriptions/7b12a8a2-f06f-456f-b6f9-aa2d92e0b2ec/resourceGroups/gpitfutures-kv-test/providers/Microsoft.KeyVault/vaults/gpitfutures-kv-test"
}

data "azurerm_key_vault_secret" "kv-bpass" {
  name         = "gpittestbastionadminpassword"
  key_vault_id = "/subscriptions/7b12a8a2-f06f-456f-b6f9-aa2d92e0b2ec/resourceGroups/gpitfutures-kv-test/providers/Microsoft.KeyVault/vaults/gpitfutures-kv-test"
}

data "azurerm_key_vault_secret" "kv-sqluser" {
  name         = "gpittestsqladminusername"
  key_vault_id = "/subscriptions/7b12a8a2-f06f-456f-b6f9-aa2d92e0b2ec/resourceGroups/gpitfutures-kv-test/providers/Microsoft.KeyVault/vaults/gpitfutures-kv-test"
}

data "azurerm_key_vault_secret" "kv-sqlpass" {
  name         = "gpittestsqladminpassword"
  key_vault_id = "/subscriptions/7b12a8a2-f06f-456f-b6f9-aa2d92e0b2ec/resourceGroups/gpitfutures-kv-test/providers/Microsoft.KeyVault/vaults/gpitfutures-kv-test"
}