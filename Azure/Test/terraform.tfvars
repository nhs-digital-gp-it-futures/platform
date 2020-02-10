###Platform###

environment                         = "test"
project                             = "gpitfutures"
region                              = "uksouth"
region1                             = "ukwest"
akspool_rg                          = "gpitfutures-test-rg-aks-pool"
akspool_nsg                         = "aks-agentpool-27929681-nsg"

###Kubernetes###

dns_service                         = "10.110.16.111"
docker_bridge                       = "172.17.16.1/24"
service_cidr                        = "10.110.16.0/24"
aksversion                          = "1.15.7"

###VNET###
sub                                 = "sub"
nsg                                 = "nsg"
vm                                  = "vm"
ip_addsp                            = "10.100.16.0/20"
sub_gateway                         = "10.100.16.0/28"
sub_aks                             = "10.100.17.0/24"
sub_bastion                         = "10.100.18.0/24"
sub_ehub                            = "10.100.19.0/24"
sub_splunk                          = "10.100.20.0/24"
sub_vm                              = "10.100.21.0/24"
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
kv_id                               = "/subscriptions/7b12a8a2-f06f-456f-b6f9-aa2d92e0b2ec/resourceGroups/gpitfutures-test-rg-kv/providers/Microsoft.KeyVault/vaults/gpitfutures-test-kv"
kv_tenant                           = "gpittesttenantid"
kv_subscription                     = "gpittestsubscriptionid"
kv_spn_name                         = "gpittestserviceprincipalnameid"
kv_spn_app_id                       = "gpittestapplicationid"
kv_spn_object_id                    = "gpittestobjectid"
kv_spn_secret                       = "gpittestclientsecretkeyid"
kv_badmin_user                      = "gpittestbastionadminusername"
kv_badmin_pass                      = "gpittestbastionadminpassword"
kv_sql_user                         = "gpittestsqladminusername"
kv_sql_pass                         = "gpittestsqladminpassword"
kv_sp_user                          = "gpittestsharepointusername"
kv_sp_pass                          = "gpittestsharepointpassword"
kv_devops_user                      = "gpittestazuredevopsvmusername"
kv_devops_pass                      = "gpittestazuredevopsvmpassword"