variable "environment" {
  type        = string
  description = "The name of the environment"
}

variable "project" {
  type        = string
  description = "The name of the project"
}

variable "region" {
  type        = string
  description = "The region the deployment should happen in"
}

variable "region1" {
  type        = string
  description = "The region the deployment should happen in"
}

variable "ip_addsp" {
  type        = string
  description = "IP address space for the Azure VNET"
}

variable "sub_aks" {
  type        = string
  description = "Subnet for Kubernetes"
}

variable "sub_bastion" {
  type        = string
  description = "Subnet for Bastion"
}

variable "sub_ehub" {
  type        = string
  description = "Subnet for eventhub"
}

variable "sub_gateway" {
  type        = string
  description = "Subnet for Gateway"
}

variable "sub_splunk" {
  type        = string
  description = "Subnet for splunk"
}

variable "sub_vm" {
  type        = string
  description = "Subnet for vm"
}

variable "vm_size" {
  type        = string
  description = "Specifies the size of the Virtual Machine"
}

variable "vm_publisher" {
  type        = string
  description = "Specifies the publisher of the image"
}

variable "vm_offer" {
  type        = string
  description = "Specifies the offer of the image used to create the virtual machine"
}

variable "vm_sku" {
  type        = string
  description = "Specifies the SKU of the image used to create the virtual machine"
}

variable "vm_version" {
  type        = string
  description = "Specifies the version of the image used to create the virtual machine"
}

variable "sql_collation" {
  type        = string
  description = "Azure SQLCollation which will be used for SQL DB"
}

variable "sql_edition" {
  type        = string
  description = "The edition of the database to be created"
}

variable "sql_size" {
  type        = string
  description = "set the performance level for the database"
}

variable "sql_retention" {
  type        = string
  description = "Specifies the number of days to keep in the Threat Detection audit logs"
}

variable "sql_version" {
  type        = string
  description = "Specifies the Azure SQL version which will be used"
}

variable "sa_tier" {
  type        = string
  description = "Defines the Tier to use for this storage account"
}

variable "sa_rep_type" {
  type        = string
  description = "Defines the type of replication to use for this storage account"
}

variable "sa_kind" {
  type        = string
  description = "Defines the Kind of account"
}

variable "waf_name" {
  type        = string
  description = "The Name of the SKU to use for this Application Gateway"
}

variable "waf_tier" {
  type        = string
  description = "The Tier of the SKU to use for this Application Gateway"
}

variable "waf_capacity" {
  type        = string
  description = "he Capacity of the SKU to use for this Application Gateway - which must be between 1 and 10"
}

