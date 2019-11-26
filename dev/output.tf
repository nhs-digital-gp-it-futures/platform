#output values for vnet related services.

output "gpit_subnet_aks" {
  value = azurerm_subnet.aks.id
}

output "gpit_subnet_bastion" {
  value = azurerm_subnet.bastion.id
}

output "gpit_subnet_gateway" {
  value = azurerm_subnet.gateway.id
}

#output values for log analytics

output "resource_id" {
  value = azurerm_log_analytics_workspace.workspace.id
}

output "workspace_shared_key" {
  value = azurerm_log_analytics_workspace.workspace.primary_shared_key
}

output "workspace_id" {
  value = azurerm_log_analytics_workspace.workspace.workspace_id
}

#output values for storage account

output "blob_password_result" {
  value = azurerm_storage_account.data.primary_access_key
}

output "blob_primary_access_key_sql_uks" {
  value = azurerm_storage_account.sqluks.primary_access_key
}

output "blob_primary_endpoint_uks" {
  value = azurerm_storage_account.sqluks.primary_blob_endpoint
}

output "blob_primary_access_key_sql_ukw" {
  value = azurerm_storage_account.sqlukw.primary_access_key
}

output "blob_primary_endpoint_ukw" {
  value = azurerm_storage_account.sqlukw.primary_blob_endpoint
}

#output values for Key Vault

#Timestamp

output "timestamp" {
  value = formatdate("YYYYMMDDhhmmss", timestamp())
  description = "Date and time Azure Resource was created"
}