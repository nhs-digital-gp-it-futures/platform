#output values for vnet related services.

output "gpit_subnet_aks" {	  
    value                   = "${azurerm_subnet.aks.id}"	
    }

output "gpit_subnet_bastion" {	  
    value                   = "${azurerm_subnet.bastion.id}"	
    }

output "gpit_subnet_gateway" {	  
    value                   = "${azurerm_subnet.gateway.id}"
    }

#output values for log analytics

output "resource_id" {	  
    value                   = "${azurerm_log_analytics_workspace.workspace.id}"	
    }

output "workspace_shared_key" {	  
    value                   = "${azurerm_log_analytics_workspace.workspace.primary_shared_key}"
    }

output "workspace_id" {	  
    value                   = "${azurerm_log_analytics_workspace.workspace.workspace_id}"
    }

#output values for storage account

output "blob_password_result" {	  
    value                   = "${azurerm_storage_account.storage.primary_access_key}"
    }

output "blob_primary_access_key_sql" {	  
    value                   = "${azurerm_storage_account.sql.primary_access_key}"
    }

output "blob_primary_endpoint" {	  
    value                   = "${azurerm_storage_account.sql.primary_blob_endpoint}"	
    }

#output values for key vault