#Key vault is created using Terraform. Terraform script isn't stored in the github respository due to this being public.
#Key vault Terraform will be stored in the AzureDevOps repo.

data "azurerm_key_vault_secret" "kv-tenant" {
  name         = "gpitdevtenantid"
  key_vault_id = "/subscriptions/7b12a8a2-f06f-456f-b6f9-aa2d92e0b2ec/resourceGroups/gpitfutures-kv-dev/providers/Microsoft.KeyVault/vaults/gpitfutures-kv-dev"
}

data "azurerm_key_vault_secret" "kv-subscription" {
  name         = "gpitdevsubscriptionid"
  key_vault_id = "/subscriptions/7b12a8a2-f06f-456f-b6f9-aa2d92e0b2ec/resourceGroups/gpitfutures-kv-dev/providers/Microsoft.KeyVault/vaults/gpitfutures-kv-dev"
}

data "azurerm_key_vault_secret" "kv-spn" {
  name         = "gpitdevserviceprincipalnameid"
  key_vault_id = "/subscriptions/7b12a8a2-f06f-456f-b6f9-aa2d92e0b2ec/resourceGroups/gpitfutures-kv-dev/providers/Microsoft.KeyVault/vaults/gpitfutures-kv-dev"
}

data "azurerm_key_vault_secret" "kv-appid" {
  name         = "gpitdevapplicationid"
  key_vault_id = "/subscriptions/7b12a8a2-f06f-456f-b6f9-aa2d92e0b2ec/resourceGroups/gpitfutures-kv-dev/providers/Microsoft.KeyVault/vaults/gpitfutures-kv-dev"
}

data "azurerm_key_vault_secret" "kv-objectid" {
  name         = "gpitdevobjectid"
  key_vault_id = "/subscriptions/7b12a8a2-f06f-456f-b6f9-aa2d92e0b2ec/resourceGroups/gpitfutures-kv-dev/providers/Microsoft.KeyVault/vaults/gpitfutures-kv-dev"
}

data "azurerm_key_vault_secret" "kv-secret" {
  name         = "gpitdevclientsecretkeyid"
  key_vault_id = "/subscriptions/7b12a8a2-f06f-456f-b6f9-aa2d92e0b2ec/resourceGroups/gpitfutures-kv-dev/providers/Microsoft.KeyVault/vaults/gpitfutures-kv-dev"
}

data "azurerm_key_vault_secret" "kv-buser" {
  name         = "gpitdevbastionadminusername"
  key_vault_id = "/subscriptions/7b12a8a2-f06f-456f-b6f9-aa2d92e0b2ec/resourceGroups/gpitfutures-kv-dev/providers/Microsoft.KeyVault/vaults/gpitfutures-kv-dev"
}

data "azurerm_key_vault_secret" "kv-bpass" {
  name         = "gpitdevbastionadminpassword"
  key_vault_id = "/subscriptions/7b12a8a2-f06f-456f-b6f9-aa2d92e0b2ec/resourceGroups/gpitfutures-kv-dev/providers/Microsoft.KeyVault/vaults/gpitfutures-kv-dev"
}

data "azurerm_key_vault_secret" "kv-sqluser" {
  name         = "gpitdevsqladminusername"
  key_vault_id = "/subscriptions/7b12a8a2-f06f-456f-b6f9-aa2d92e0b2ec/resourceGroups/gpitfutures-kv-dev/providers/Microsoft.KeyVault/vaults/gpitfutures-kv-dev"
}

data "azurerm_key_vault_secret" "kv-sqlpass" {
  name         = "gpitdevsqladminpassword"
  key_vault_id = "/subscriptions/7b12a8a2-f06f-456f-b6f9-aa2d92e0b2ec/resourceGroups/gpitfutures-kv-dev/providers/Microsoft.KeyVault/vaults/gpitfutures-kv-dev"
}

