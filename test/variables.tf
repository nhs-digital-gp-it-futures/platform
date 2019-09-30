variable "environment" {
  type                  = "string"
  description           = "The name of the environment"
}

variable "project" {
  type                  = "string"
  description           = "The name of the project"
}

variable "region" {
  type                  = "string"
  description           = "The region the deployment should happen in"
}

variable "ip_addsp" {
  type                  = "string"
  description           = "IP address space for the Azure VNET"
}

variable "sub_aks" {
  type                  = "string"
  description           = "Subnet for Kubernetes"
}

variable "sub_bastion" {
  type                  = "string"
  description           = "Subnet for Bastion"
}

variable "sub_gateway" {
  type                  = "string"
  description           = "Subnet for Gateway"
}

variable "sub_splunk" {
  type                  = "string"
  description           = "Subnet for splunk"
}