#Key vault is created using Terraform. Terraform script isn't stored in the github respository due to this being public.
#Key vault Terraform will be stored in the AzureDevOps repo.

data "azurerm_key_vault_secret" "kv-tenant" {
  name         = "gpitprodtenantid"
  key_vault_id = "/subscriptions/7b12a8a2-f06f-456f-b6f9-aa2d92e0b2ec/resourceGroups/gpitfutures-prod-rg-kv/providers/Microsoft.KeyVault/vaults/gpitfutures-kv-prod"
}

data "azurerm_key_vault_secret" "kv-subscription" {
  name         = "gpitprodsubscriptionid"
  key_vault_id = "/subscriptions/7b12a8a2-f06f-456f-b6f9-aa2d92e0b2ec/resourceGroups/gpitfutures-prod-rg-kv/providers/Microsoft.KeyVault/vaults/gpitfutures-kv-prod"
}

data "azurerm_key_vault_secret" "kv-spn" {
  name         = "gpitprodserviceprincipalnameid"
  key_vault_id = "/subscriptions/7b12a8a2-f06f-456f-b6f9-aa2d92e0b2ec/resourceGroups/gpitfutures-prod-rg-kv/providers/Microsoft.KeyVault/vaults/gpitfutures-kv-prod"
}

data "azurerm_key_vault_secret" "kv-appid" {
  name         = "gpitprodapplicationid"
  key_vault_id = "/subscriptions/7b12a8a2-f06f-456f-b6f9-aa2d92e0b2ec/resourceGroups/gpitfutures-prod-rg-kv/providers/Microsoft.KeyVault/vaults/gpitfutures-kv-prod"
}

data "azurerm_key_vault_secret" "kv-objectid" {
  name         = "gpitprodobjectid"
  key_vault_id = "/subscriptions/7b12a8a2-f06f-456f-b6f9-aa2d92e0b2ec/resourceGroups/gpitfutures-prod-rg-kv/providers/Microsoft.KeyVault/vaults/gpitfutures-kv-prod"
}

data "azurerm_key_vault_secret" "kv-secret" {
  name         = "gpitprodclientsecretkeyid"
  key_vault_id = "/subscriptions/7b12a8a2-f06f-456f-b6f9-aa2d92e0b2ec/resourceGroups/gpitfutures-prod-rg-kv/providers/Microsoft.KeyVault/vaults/gpitfutures-kv-prod"
}

data "azurerm_key_vault_secret" "kv-buser" {
  name         = "gpitprodbastionadminusername"
  key_vault_id = "/subscriptions/7b12a8a2-f06f-456f-b6f9-aa2d92e0b2ec/resourceGroups/gpitfutures-prod-rg-kv/providers/Microsoft.KeyVault/vaults/gpitfutures-kv-prod"
}

data "azurerm_key_vault_secret" "kv-bpass" {
  name         = "gpitprodbastionadminpassword"
  key_vault_id = "/subscriptions/7b12a8a2-f06f-456f-b6f9-aa2d92e0b2ec/resourceGroups/gpitfutures-prod-rg-kv/providers/Microsoft.KeyVault/vaults/gpitfutures-kv-prod"
}

data "azurerm_key_vault_secret" "kv-sqluser" {
  name         = "gpitprodsqladminusername"
  key_vault_id = "/subscriptions/7b12a8a2-f06f-456f-b6f9-aa2d92e0b2ec/resourceGroups/gpitfutures-prod-rg-kv/providers/Microsoft.KeyVault/vaults/gpitfutures-kv-prod"
}

data "azurerm_key_vault_secret" "kv-sqlpass" {
  name         = "gpitprodsqladminpassword"
  key_vault_id = "/subscriptions/7b12a8a2-f06f-456f-b6f9-aa2d92e0b2ec/resourceGroups/gpitfutures-prod-rg-kv/providers/Microsoft.KeyVault/vaults/gpitfutures-kv-prod"
}