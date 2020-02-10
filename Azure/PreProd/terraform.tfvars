###Platform###

environment                         = "pprod"
project                             = "gpitfutures"
region                              = "uksouth"
region1                             = "ukwest"
akspool_rg                          = "gpitfutures-pprod-rg-aks-pool"
akspool_nsg                         = "aks-agentpool-42565127-nsg"

###Kubernetes###

dns_service                         = "10.110.32.111"
docker_bridge                       = "172.17.32.1/24"
service_cidr                        = "10.110.32.0/24"
aksversion                          = "1.15.7"

###VNET###
sub                                 = "sub"
nsg                                 = "nsg"
vm                                  = "vm"
ip_addsp                            = "10.100.32.0/20"
sub_gateway                         = "10.100.32.0/28"
sub_aks                             = "10.100.33.0/24"
sub_bastion                         = "10.100.34.0/24"
sub_ehub                            = "10.100.35.0/24"
sub_splunk                          = "10.100.36.0/24"
sub_vm                              = "10.100.37.0/24"
waf_name                            = "WAF_v2"
waf_tier                            = "WAF_v2"
waf_capacity                        = "1"
gov_ip_add                          = "194.101.83.0/24"

###SQL###
sql_collation                       = "SQL_Latin1_General_CP1_CI_AS"
sql_edition                         = "Standard"
sql_size                            = "S1"
sql_retention                       = "30"
sql_version                         = "12.0"

###VM###
vm_size                             = "Standard_F4s"
vm_publisher                        = "Canonical"
vm_offer                            = "UbuntuServer"
vm_sku                              = "18.04-LTS"
vm_version                          = "latest"
sa_tier                             = "standard"
sa_rep_type                         = "grs"
sa_kind                             = "StorageV2"

###Key Vault###
kv_id                               = "/subscriptions/7b12a8a2-f06f-456f-b6f9-aa2d92e0b2ec/resourceGroups/gpitfutures-pprod-rg-kv/providers/Microsoft.KeyVault/vaults/gpitfutures-pprod-kv"
kv_tenant                           = "gpitpprodtenantid"
kv_subscription                     = "gpitpprodsubscriptionid"
kv_spn_name                         = "gpitpprodserviceprincipalnameid"
kv_spn_app_id                       = "gpitpprodapplicationid"
kv_spn_object_id                    = "gpitpprodobjectid"
kv_spn_secret                       = "gpitpprodclientsecretkeyid"
kv_badmin_user                      = "gpitpprodbastionadminusername"
kv_badmin_pass                      = "gpitpprodbastionadminpassword"
kv_sql_user                         = "gpitpprodsqladminusername"
kv_sql_pass                         = "gpitpprodsqladminpassword"
kv_sp_user                          = "gpitpprodsharepointusername"
kv_sp_pass                          = "gpitpprodsharepointpassword"
kv_devops_user                      = "gpitpprodazuredevopsvmusername"
kv_devops_pass                      = "gpitpprodazuredevopsvmpassword"