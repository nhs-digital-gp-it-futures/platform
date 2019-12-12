#Key vault is created using Terraform. Terraform script isn't stored in the github respository due to this being public.
#Key vault Terraform will be stored in the AzureDevOps repo.

data "azurerm_key_vault_secret" "kv-tenant" {
  name         = "gpitpprodtenantid"
  key_vault_id = "/subscriptions/7b12a8a2-f06f-456f-b6f9-aa2d92e0b2ec/resourceGroups/gpitfutures-pprod-rg-kv/providers/Microsoft.KeyVault/vaults/gpitfutures-kv-pprod"
}

data "azurerm_key_vault_secret" "kv-subscription" {
  name         = "gpitpprodsubscriptionid"
  key_vault_id = "/subscriptions/7b12a8a2-f06f-456f-b6f9-aa2d92e0b2ec/resourceGroups/gpitfutures-pprod-rg-kv/providers/Microsoft.KeyVault/vaults/gpitfutures-kv-pprod"
}

data "azurerm_key_vault_secret" "kv-spn" {
  name         = "gpitpprodserviceprincipalnameid"
  key_vault_id = "/subscriptions/7b12a8a2-f06f-456f-b6f9-aa2d92e0b2ec/resourceGroups/gpitfutures-pprod-rg-kv/providers/Microsoft.KeyVault/vaults/gpitfutures-kv-pprod"
}

data "azurerm_key_vault_secret" "kv-appid" {
  name         = "gpitpprodapplicationid"
  key_vault_id = "/subscriptions/7b12a8a2-f06f-456f-b6f9-aa2d92e0b2ec/resourceGroups/gpitfutures-pprod-rg-kv/providers/Microsoft.KeyVault/vaults/gpitfutures-kv-pprod"
}

data "azurerm_key_vault_secret" "kv-objectid" {
  name         = "gpitpprodobjectid"
  key_vault_id = "/subscriptions/7b12a8a2-f06f-456f-b6f9-aa2d92e0b2ec/resourceGroups/gpitfutures-pprod-rg-kv/providers/Microsoft.KeyVault/vaults/gpitfutures-kv-pprod"
}

data "azurerm_key_vault_secret" "kv-secret" {
  name         = "gpitpprodclientsecretkeyid"
  key_vault_id = "/subscriptions/7b12a8a2-f06f-456f-b6f9-aa2d92e0b2ec/resourceGroups/gpitfutures-pprod-rg-kv/providers/Microsoft.KeyVault/vaults/gpitfutures-kv-pprod"
}

data "azurerm_key_vault_secret" "kv-buser" {
  name         = "gpitpprodbastionadminusername"
  key_vault_id = "/subscriptions/7b12a8a2-f06f-456f-b6f9-aa2d92e0b2ec/resourceGroups/gpitfutures-pprod-rg-kv/providers/Microsoft.KeyVault/vaults/gpitfutures-kv-pprod"
}

data "azurerm_key_vault_secret" "kv-bpass" {
  name         = "gpitpprodbastionadminpassword"
  key_vault_id = "/subscriptions/7b12a8a2-f06f-456f-b6f9-aa2d92e0b2ec/resourceGroups/gpitfutures-pprod-rg-kv/providers/Microsoft.KeyVault/vaults/gpitfutures-kv-pprod"
}

data "azurerm_key_vault_secret" "kv-sqluser" {
  name         = "gpitpprodsqladminusername"
  key_vault_id = "/subscriptions/7b12a8a2-f06f-456f-b6f9-aa2d92e0b2ec/resourceGroups/gpitfutures-pprod-rg-kv/providers/Microsoft.KeyVault/vaults/gpitfutures-kv-pprod"
}

data "azurerm_key_vault_secret" "kv-sqlpass" {
  name         = "gpitpprodsqladminpassword"
  key_vault_id = "/subscriptions/7b12a8a2-f06f-456f-b6f9-aa2d92e0b2ec/resourceGroups/gpitfutures-pprod-rg-kv/providers/Microsoft.KeyVault/vaults/gpitfutures-kv-pprod"
}