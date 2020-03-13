variable "aksversion" {
  type        = "string"
  description = "The version of Kubernetes to deploy"
}

variable "environment" {
  type        = "string"
  description = "The name of the environment"
}

variable "project" {
  type        = "string"
  description = "The name of the project"
}

variable "region" {
  type        = "string"
  description = "Azure Region"
}

variable "region1" {
  type        = "string"
  description = "Azure Region"
}

variable "ip_addsp" {
  type        = "string"
  description = "IP address space for the Azure VNET"
}

variable "nsg" {
  type        = "string"
  description = "Subnets for the address space"
}

variable "sub" {
  type        = "string"
  description = "Subnets for the address space"
}

variable "sub_aks" {
  type        = "string"
  description = "Subnet for Kubernetes"
}

variable "sub_bastion" {
  type        = "string"
  description = "Subnet for Bastion"
}

variable "sub_ehub" {
  type        = "string"
  description = "Subnet for eventhub"
}

variable "sub_gateway" {
  type        = "string"
  description = "Subnet for Gateway"
}

variable "sub_splunk" {
  type        = "string"
  description = "Subnet for splunk"
}

variable "sub_vm" {
  type        = "string"
  description = "Subnet for vm"
}

variable "vm_size" {
  type        = "string"
  description = "Size of the Virtual Machine"
}

variable "vm_publisher" {
  type        = "string"
  description = "Publisher of the image"
}

variable "vm_offer" {
  type        = "string"
  description = "Offer of the image"
}

variable "vm_sku" {
  type        = "string"
  description = "Specifies the SKU of the image"
}

variable "vm_version" {
  type        = "string"
  description = "Specifies the version of the image"
}

variable "sql_collation" {
  type        = "string"
  description = "Azure SQLCollation which will be used for SQL DB"
}

variable "sql_edition" {
  type        = "string"
  description = "The edition of the database to be created"
}

variable "sql_size" {
  type        = "string"
  description = "set the performance level for the database"
}

variable "sql_retention" {
  type        = "string"
  description = "Specifies the number of days to keep in the Threat Detection audit logs"
}

variable "sql_version" {
  type        = "string"
  description = "Specifies the Azure SQL version which will be used"
}

variable "sa_tier" {
  type        = "string"
  description = "Defines the Tier to use for this storage account"
}

variable "sa_rep_type" {
  type        = "string"
  description = "Defines the type of replication to use for this storage account"
}

variable "sa_kind" {
  type        = "string"
  description = "Defines the Kind of account"
}

variable "waf_name" {
  type        = "string"
  description = "The Name of the SKU to use for this Application Gateway"
}

variable "waf_tier" {
  type        = "string"
  description = "The Tier of the SKU to use for this Application Gateway"
}

variable "waf_capacity" {
  type        = "string"
  description = "he Capacity of the SKU to use for this Application Gateway - which must be between 1 and 10"
}

variable "vm" {
  type        = "string"
  description = "he Capacity of the SKU to use for this Application Gateway - which must be between 1 and 10"
}

variable "gov_ip_add" {
  type        = "string"
  description = "Gov IP Address used with Bridge Waterplace"
}

variable "kv_id" {
  type        = "string"
  description = "ResourceID for the Azure Storage Account"
}

variable "kv_tenant" {
  type        = "string"
  description = "GP IT Future Buying Catalogue Tenant ID"
}

variable "kv_subscription" {
  type        = "string"
  description = "GP IT Future Buying Catalogue Subscription ID"
}

variable "kv_spn_name" {
  type        = "string"
  description = "GP IT Future Buying Catalogue Service Principal"
}

variable "kv_spn_app_id" {
  type        = "string"
  description = "GP IT Future Buying Catalogue Application ID"
}

variable "kv_spn_object_id" {
  type        = "string"
  description = "GP IT Future Buying Catalogue Object ID"
}

variable "kv_spn_secret" {
  type        = "string"
  description = "GP IT Future Buying Catalogue Service Prinicpal Secret"
}

variable "kv_badmin_user" {
  type        = "string"
  description = "GP IT Future Buying Catalogue bastion host username"
}

variable "kv_badmin_pass" {
  type        = "string"
  description = "GP IT Future Buying Catalogue bastion host password"
}

variable "kv_sql_user" {
  type        = "string"
  description = "GP IT Future Buying Catalogue Azure SQL username"
}

variable "kv_sql_pass" {
  type        = "string"
  description = "GP IT Future Buying Catalogue Azure SQL password"
}

variable "kv_sp_user" {
  type        = "string"
  description = "GP IT Future Buying Catalogue SharePoint Online user"
}

variable "kv_sp_pass" {
  type        = "string"
  description = "GP IT Future Buying Catalogue SharePoint Online password"
}

variable "dns_service" {
  type        = "string"
  description = "DNS Service IP Address used by AKS"
}

variable "docker_bridge" {
  type        = "string"
  description = "IP address for the Docker Bridge"
}

variable "service_cidr" {
  type        = "string"
  description = "subnet for the AKS pool"
}
variable "akspool_rg" {
  type        = "string"
  description = "Resource Group the the AKS Pool"
}

variable "akspool_nsg" {
  type        = "string"
  description = "NSG for the AKS Pool"
}

variable "dns_label" {
  type        = "string"
  description = "DNS label to be used for public IP Address"
}

variable "sql_login" {
  type        = "string"
  description = "DNS label to be used for public IP Address"
}

variable "kv_sql_admins" {
  type        = "string"
  description = "DNS label to be used for public IP Address"
}

variable "sql_pri" {
  type        = "string"
  description = "DNS label to be used for public IP Address"
}

variable "sql_pub" {
  type        = "string"
  description = "DNS label to be used for public IP Address"
}

variable "aks_ips" {
  type        = "string"
  description = "DNS label to be used for public IP Address"
}