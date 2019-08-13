variable "virtual_network_name" {

description = "The name for the virtual network."

default = "FLOAPP-vNet-Terra"

}

variable "address_space" {

description = "The address space that is used by the virtual network. You can supply more than one address space. Changing this forces a new resource to be created."

default = "10.0.0.0/16"

}

variable "subnetname_prefixfrontend" {

description = "The shortened abbreviation to represent your resource group that will go on the front of some resources."

default = "Frontend"

}

variable "subnetname_prefixbackend" {

description = "The shortened abbreviation to represent your resource group that will go on the front of some resources."

default = "Backend"

}

variable "subnet_prefixfrontend" {

description = "The address prefix to use for the subnet."

default = "10.0.10.0/24"

}

variable "subnet_prefixbackend" {

description = "The address prefix to use for the subnet."

default = "10.0.20.0/24"

}