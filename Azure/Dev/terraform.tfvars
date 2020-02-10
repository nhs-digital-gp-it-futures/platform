###Platform###

environment                         = "dev"
project                             = "gpitfutures"
region                              = "uksouth"
region1                             = "ukwest"
akspool_rg                          = "gpitfutures-dev-rg-aks-pool"
akspool_nsg                         = "aks-agentpool-42244270-nsg"

###Kubernetes###

dns_service                         = "10.110.0.111"
docker_bridge                       = "172.17.0.1/24"
service_cidr                        = "10.110.0.0/24"
aksversion                          = "1.15.7"

###VNET###
sub                                 = "sub"
nsg                                 = "nsg"
vm                                  = "vm"
ip_addsp                            = "10.100.0.0/20"
sub_gateway                         = "10.100.0.0/28"
sub_aks                             = "10.100.1.0/24"
sub_bastion                         = "10.100.2.0/24"
sub_ehub                            = "10.100.3.0/24"
sub_splunk                          = "10.100.4.0/24"
sub_vm                              = "10.100.5.0/24"
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
vm_size                             = "Standard_B2s"
vm_publisher                        = "Canonical"
vm_offer                            = "UbuntuServer"
vm_sku                              = "18.04-LTS"
vm_version                          = "latest"
sa_tier                             = "standard"
sa_rep_type                         = "grs"
sa_kind                             = "StorageV2"

###Key Vault###
kv_id                               = "/subscriptions/7b12a8a2-f06f-456f-b6f9-aa2d92e0b2ec/resourceGroups/gpitfutures-dev-rg-kv/providers/Microsoft.KeyVault/vaults/gpitfutures-dev-kv"
kv_tenant                           = "gpitdevtenantid"
kv_subscription                     = "gpitdevsubscriptionid"
kv_spn_name                         = "gpitdevserviceprincipalnameid"
kv_spn_app_id                       = "gpitdevapplicationid"
kv_spn_object_id                    = "gpitdevobjectid"
kv_spn_secret                       = "gpitdevclientsecretkeyid"
kv_badmin_user                      = "gpitdevbastionadminusername"
kv_badmin_pass                      = "gpitdevbastionadminpassword"
kv_sql_user                         = "gpitdevsqladminusername"
kv_sql_pass                         = "gpitdevsqladminpassword"
kv_sp_user                          = "gpitdevsharepointusername"
kv_sp_pass                          = "gpitdevsharepointpassword"
kv_devops_user                      = "gpitdevazuredevopsvmusername"
kv_devops_pass                      = "gpitdevazuredevopsvmpassword"