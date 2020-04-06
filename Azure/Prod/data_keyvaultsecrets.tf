#Key vault is created using Terraform. Terraform script isn't stored in the github respository due to this being public.
#Key vault Terraform will be stored in the AzureDevOps repo.

data "azurerm_key_vault_secret" "kv-tenant" {
  name         = var.kv_tenant
  key_vault_id = var.kv_id
}

data "azurerm_key_vault_secret" "kv-subscription" {
  name         = var.kv_subscription
  key_vault_id = var.kv_id
}

data "azurerm_key_vault_secret" "kv-spn" {
  name         = var.kv_spn_name
  key_vault_id = var.kv_id
}

data "azurerm_key_vault_secret" "kv-appid" {
  name         = var.kv_spn_app_id
  key_vault_id = var.kv_id
}

data "azurerm_key_vault_secret" "kv-objectid" {
  name         = var.kv_spn_object_id
  key_vault_id = var.kv_id
}

data "azurerm_key_vault_secret" "kv-secret" {
  name         = var.kv_spn_secret
  key_vault_id = var.kv_id
}

data "azurerm_key_vault_secret" "kv-buser" {
  name         = var.kv_badmin_user
  key_vault_id = var.kv_id
}

data "azurerm_key_vault_secret" "kv-bpass" {
  name         = var.kv_badmin_pass
  key_vault_id = var.kv_id
}

data "azurerm_key_vault_secret" "kv-sqluser" {
  name         = var.kv_sql_user
  key_vault_id = var.kv_id
}

data "azurerm_key_vault_secret" "kv-sqlpass" {
  name         = var.kv_sql_pass
  key_vault_id = var.kv_id
}

data "azurerm_key_vault_secret" "kv-sp-user" {
  name         = var.kv_sp_user
  key_vault_id = var.kv_id
}

data "azurerm_key_vault_secret" "kv-sp-pass" {
  name         = var.kv_sp_pass
  key_vault_id = var.kv_id
}

data "azurerm_key_vault_secret" "kv-sqladmins" {
  name         = var.kv_sql_admins
  key_vault_id = var.kv_id
}
