###Platform###

environment                         = "prod"
project                             = "gpitfutures"
region                              = "uksouth"
region1                             = "ukwest"
akspool_rg                          = "gpitfutures-prod-rg-aks-pool"
akspool_nsg                         = "aks-agentpool-41598990-nsg"

###Kubernetes###

dns_service                         = "10.110.48.111"
docker_bridge                       = "172.17.48.1/24"
service_cidr                        = "10.110.48.0/24"
aksversion                          = "1.15.7"

###VNET###
sub                                 = "sub"
nsg                                 = "nsg"
vm                                  = "vm"
ip_addsp                            = "10.100.48.0/20"
sub_gateway                         = "10.100.48.0/28"
sub_aks                             = "10.100.49.0/24"
sub_bastion                         = "10.100.50.0/24"
sub_ehub                            = "10.100.51.0/24"
sub_splunk                          = "10.100.52.0/24"
sub_vm                              = "10.100.53.0/24"
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
vm_size                             = "Standard_B4ms"
vm_publisher                        = "Canonical"
vm_offer                            = "UbuntuServer"
vm_sku                              = "18.04-LTS"
vm_version                          = "latest"
sa_tier                             = "standard"
sa_rep_type                         = "grs"
sa_kind                             = "StorageV2"

###Key Vault###
kv_id                               = "/subscriptions/7b12a8a2-f06f-456f-b6f9-aa2d92e0b2ec/resourceGroups/gpitfutures-prod-rg-kv/providers/Microsoft.KeyVault/vaults/gpitfutures-prod-kv"
kv_tenant                           = "gpitprodtenantid"
kv_subscription                     = "gpitprodsubscriptionid"
kv_spn_name                         = "gpitprodserviceprincipalnameid"
kv_spn_app_id                       = "gpitprodapplicationid"
kv_spn_object_id                    = "gpitprodobjectid"
kv_spn_secret                       = "gpitprodclientsecretkeyid"
kv_badmin_user                      = "gpitprodbastionadminusername"
kv_badmin_pass                      = "gpitprodbastionadminpassword"
kv_sql_user                         = "gpitprodsqladminusername"
kv_sql_pass                         = "gpitprodsqladminpassword"
kv_sp_user                          = "gpitprodsharepointusername"
kv_sp_pass                          = "gpitprodsharepointpassword"
kv_devops_user                      = "gpitprodazuredevopsvmusername"
kv_devops_pass                      = "gpitprodazuredevopsvmpassword"