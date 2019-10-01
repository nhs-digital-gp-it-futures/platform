environment                         = "test"
project                             = "gpitfuture"
region                              = "uksouth"
ip_addsp                            = "10.100.0.0/21"
sub_aks                             = "10.100.0.0/24"
sub_bastion                         = "10.100.1.0/24"
sub_gateway                         = "10.100.2.0/29"
sub_splunk                          = "10.100.3.0/24"
sql_collation                       = "SQL_Latin1_General_CP1_CI_AS"
sql_edition                         = "Standard"
sql_size                            = "S1"
sql_retention                       = "30"
sql_version                         = "12.0"
vm_size                             = "Standard_D2_v3"
vm_publisher                        = "Canonical"
vm_offer                            = "UbuntuServer"
vm_sku                              = "18.04-LTS"
vm_version                          = "latest"
sa_tier                             = "standard"
sa_rep_type                         = "grs"
sa_kind                             = "StorageV2"
waf_name                            = "WAF_Medium"
waf_tier                            = "WAF"
waf_capacity                        = "1"