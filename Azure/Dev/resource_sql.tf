resource "azurerm_resource_group" "bc-sql-pri" {
  name     = "${var.project}-${var.environment}-rg-sql-pri"
  location = var.region
  tags = {
    environment = var.environment
  }
}

resource "azurerm_resource_group" "bc-sql-sec" {
  name     = "${var.project}-${var.environment}-rg-sql-sec"
  location = var.region1
  tags = {
    environment = var.environment
  }
}

resource "azurerm_sql_server" "bc-sql-pri" {
  name                         = "${var.project}-${var.environment}-sql-pri"
  resource_group_name          = azurerm_resource_group.bc-sql-pri.name
  location                     = var.region
  version                      = var.sql_version
  administrator_login          = data.azurerm_key_vault_secret.kv-sqluser.value
  administrator_login_password = data.azurerm_key_vault_secret.kv-sqlpass.value
  lifecycle {
    ignore_changes = [
      identity
    ]
  }
}

resource "azurerm_sql_firewall_rule" "bc-sql-pri" {
  name                = "azure_services"
  resource_group_name = azurerm_resource_group.bc-sql-pri.name
  server_name         = azurerm_sql_server.bc-sql-pri.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}

resource "azurerm_sql_database" "sql-bapi-pri" {
  name                             = "${var.project}-${var.environment}-${var.sql_pri}"
  resource_group_name              = azurerm_resource_group.bc-sql-pri.name
  location                         = var.region
  server_name                      = azurerm_sql_server.bc-sql-pri.name
  collation                        = var.sql_collation
  edition                          = var.sql_edition
  requested_service_objective_name = var.sql_size

}

resource "azurerm_sql_database" "sql-isapi" {
  name                             = "${var.project}-${var.environment}-db-isapi"
  resource_group_name              = azurerm_resource_group.bc-sql-pri.name
  location                         = var.region
  server_name                      = azurerm_sql_server.bc-sql-pri.name
  collation                        = var.sql_collation
  edition                          = var.sql_edition
  requested_service_objective_name = var.sql_size

}

resource "azurerm_advanced_threat_protection" "bc-sql-pri" {
  target_resource_id = azurerm_storage_account.sqluks.id
  enabled            = true
}

resource "azurerm_sql_active_directory_administrator" "bc-sql-pri" {
  server_name         = azurerm_sql_server.bc-sql-pri.name
  resource_group_name = azurerm_resource_group.bc-sql-pri.name
  login               = var.sql_login
  tenant_id           = data.azurerm_key_vault_secret.kv-tenant.value
  object_id           = data.azurerm_key_vault_secret.kv-sqladmins.value
}


//Code from https://github.com/terraform-providers/terraform-provider-azurerm/issues/1802
//must use arm until TF implements these natively see https://github.com/terraform-providers/terraform-provider-azurerm/issues/1802
// backupLongTermRetentionPolicies -> https://docs.microsoft.com/en-us/azure/templates/microsoft.sql/2017-03-01-preview/servers/databases/backuplongtermretentionpolicies
// backupShortTermRetentionPolicies -> https://docs.microsoft.com/en-us/azure/templates/microsoft.sql/2017-10-01-preview/servers/databases/backupshorttermretentionpolicies
//note since we are defining these child resources in an ARM based on parent resources defined
//with TF we have to use their full names see https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/child-resource-name-type#outside-parent-resource
//Section deliberately kept for testing purposes but commented out in dev (as we don't actually want the policy applied in dev)
# resource "azurerm_template_deployment" "bc-sql-pri-retention" {
#   name                = "bc-sql-pri-retention"
#   resource_group_name = azurerm_resource_group.bc-sql-pri.name
#   template_body = <<DEPLOY
# {
#   "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
#   "contentVersion": "1.0.0.0",
#   "resources": [
#     {
#       "apiVersion" : "2017-03-01-preview",
#       "type" : "Microsoft.Sql/servers/databases/backupLongTermRetentionPolicies",
#       "name" : "${azurerm_sql_server.bc-sql-pri.name}/${azurerm_sql_database.sql-bapi-pri.name}/default",
#       "properties" : {
#         "weeklyRetention": "P6W",
#         "monthlyRetention": "P12W",
#         "yearlyRetention": "P7Y",
#         "weekOfYear": "17"
#       }
#     },
#     {
#       "apiVersion": "2017-10-01-preview",
#       "type": "Microsoft.Sql/servers/databases/backupShortTermRetentionPolicies",
#       "name": "${azurerm_sql_server.bc-sql-pri.name}/${azurerm_sql_database.sql-bapi-pri.name}/default",
#       "properties": {
#         "retentionDays": 14
#       }
#     },
#     {
#       "apiVersion" : "2017-03-01-preview",
#       "type" : "Microsoft.Sql/servers/databases/backupLongTermRetentionPolicies",
#       "name" : "${azurerm_sql_server.bc-sql-pri.name}/${azurerm_sql_database.sql-isapi.name}/default",
#       "properties" : {
#         "weeklyRetention": "P6W",
#         "monthlyRetention": "P12W",
#         "yearlyRetention": "P7Y",
#         "weekOfYear": "17"
#       }
#     },
#     {
#       "apiVersion": "2017-10-01-preview",
#       "type": "Microsoft.Sql/servers/databases/backupShortTermRetentionPolicies",
#       "name": "${azurerm_sql_server.bc-sql-pri.name}/${azurerm_sql_database.sql-isapi.name}/default",
#       "properties": {
#         "retentionDays": 14
#       }
#     }
#   ]
# }
# DEPLOY
  
#   deployment_mode = "Incremental"
# }