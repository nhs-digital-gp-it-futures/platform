data "azurerm_key_vault_secret" "kv-tenant" {
  name = "gpitdevtenantid"
  vault_uri = "https://gpitfuture-kv-dev.vault.azure.net/"
}

data "azurerm_key_vault_secret" "kv-subscription" {
  name = "gpitdevsubscriptionid"
  vault_uri = "https://gpitfuture-kv-dev.vault.azure.net/"
}

data "azurerm_key_vault_secret" "kv-spn" {
  name = "gpitdevserviceprincipalnameid"
  vault_uri = "https://gpitfuture-kv-dev.vault.azure.net/"
}

data "azurerm_key_vault_secret" "kv-appid" {
  name = "gpitdevapplicationid"
  vault_uri = "https://gpitfuture-kv-dev.vault.azure.net/"
}

data "azurerm_key_vault_secret" "kv-objectid" {
  name = "gpitdevobjectid"
  vault_uri = "https://gpitfuture-kv-dev.vault.azure.net/"
}

data "azurerm_key_vault_secret" "kv-secret" {
  name = "gpitdevclientsecretkeyid"
  vault_uri = "https://gpitfuture-kv-dev.vault.azure.net/"
}

data "azurerm_key_vault_secret" "kv-buser" {
  name = "gpitdevbastionadminusername"
  vault_uri = "https://gpitfuture-kv-dev.vault.azure.net/"
}

data "azurerm_key_vault_secret" "kv-bpass" {
  name = "gpitdevbastionadminpassword"
  vault_uri = "https://gpitfuture-kv-dev.vault.azure.net/"
}

data "azurerm_key_vault_secret" "kv-sqluser" {
  name = "gpitdevsqladminusername"
  vault_uri = "https://gpitfuture-kv-dev.vault.azure.net/"
}

data "azurerm_key_vault_secret" "kv-sqlpass" {
  name = "gpitdevsqladminpassword"
  vault_uri = "https://gpitfuture-kv-dev.vault.azure.net/"
}