terraform {
  backend "azurerm" {
    resource_group_name             = "gpitfuture-sa-tf"
    storage_account_name            = "gpitfuturesatf"
    container_name                  = "terraform"
    key                             = "test.keyvault.tfstate"
  }
}

resource "azurerm_resource_group" "keyvault" {
    name                            = "${var.project}-kv-${var.environment}"
    location                        = "${var.region}"
    tags                            = {
        environment                 = "${var.environment}"
  }
}

resource "azurerm_key_vault" "keyvault" {
  name                              = "${var.project}-kv-${var.environment}"
  location                          = "${var.region}"
  resource_group_name               = "${azurerm_resource_group.keyvault.name}"
  enabled_for_disk_encryption       = "true"
  tenant_id                         = "50f6071f-bbfe-401a-8803-673748e629e2"
  sku_name                          = "standard"
  enabled_for_template_deployment   = "true"
  tags                              = {
    environment                     = "${var.environment}"
  }
}

resource "azurerm_key_vault_access_policy" "access1" {
  key_vault_id                      = "${azurerm_key_vault.keyvault.id}"
  tenant_id                         = "50f6071f-bbfe-401a-8803-673748e629e2"
  object_id                          = "4828a1db-617b-452b-a0fb-cee443cab420"

key_permissions                  = [

                                      "backup",
                                      "create",
                                      "decrypt",
                                      "delete",
                                      "encrypt",
                                      "get",
                                      "import",
                                      "list",
                                      "purge",
                                      "recover",
                                      "restore",
                                      "sign",
                                      "unwrapKey",
                                      "update",
                                      "verify",
                                      "wrapKey"
    ]

secret_permissions                  = [

                                      "backup",
                                      "delete",
                                      "get",
                                      "list",
                                      "purge",
                                      "recover",
                                      "restore",
                                      "set"
    ]

}

resource "azurerm_key_vault_access_policy" "access2" {
  key_vault_id                      = "${azurerm_key_vault.keyvault.id}"
  tenant_id                         = "50f6071f-bbfe-401a-8803-673748e629e2"
  object_id                          = "e0719998-022b-4bee-a339-f24b67b38dca"

  key_permissions                  = [

                                      "backup",
                                      "create",
                                      "decrypt",
                                      "delete",
                                      "encrypt",
                                      "get",
                                      "import",
                                      "list",
                                      "purge",
                                      "recover",
                                      "restore",
                                      "sign",
                                      "unwrapKey",
                                      "update",
                                      "verify",
                                      "wrapKey"
    ]


secret_permissions                  = [

                                      "backup",
                                      "delete",
                                      "get",
                                      "list",
                                      "purge",
                                      "recover",
                                      "restore",
                                      "set"
]

}

resource "azurerm_key_vault_secret" "kv-tenant" {
  name                              = "gpitdevtenantid"
  value                             = "50f6071f-bbfe-401a-8803-673748e629e2"
  content_type                      = "GP IT Future Buying Catalogue Tenant ID"
  key_vault_id                      = "${azurerm_key_vault.keyvault.id}"
  tags                              = {
    environment                     = "${var.environment}"
  }
}

resource "azurerm_key_vault_secret" "kv-subscription" {
  name                              = "gpitdevsubscriptionid"
  value                             = "7b12a8a2-f06f-456f-b6f9-aa2d92e0b2ec"
  content_type                      = "GP IT Future Buying Catalogue Subscription ID"
  key_vault_id                      = "${azurerm_key_vault.keyvault.id}"
  tags                              = {
    environment                     = "${var.environment}"
  }
}

resource "azurerm_key_vault_secret" "kv-spn" {
  name                              = "gpitdevserviceprincipalnameid"
  value                             = "NHSAPP-BuyingCatalogue"
  content_type                      = "GP IT Future Buying Catalogue Service Principal"
  key_vault_id                      = "${azurerm_key_vault.keyvault.id}"
  tags                              = {
    environment                     = "${var.environment}"
  }
}

resource "azurerm_key_vault_secret" "kv-appid" {
  name                              = "gpitdevapplicationid"
  value                             = "cd7c98b2-31ca-4e02-9100-981697324ac5"
  content_type                      = "GP IT Future Buying Catalogue Application ID"
  key_vault_id                      = "${azurerm_key_vault.keyvault.id}"
  tags                              = {
    environment                     = "${var.environment}"
  }
}

resource "azurerm_key_vault_secret" "kv-objectid" {
  name                  = "gpitdevobjectid"
  value                 = "e0719998-022b-4bee-a339-f24b67b38dca"
  content_type          = "GP IT Future Buying Catalogue Object ID"
  key_vault_id          = "${azurerm_key_vault.keyvault.id}"
  tags                  = {
    environment         = "${var.environment}"
  }
}

resource "azurerm_key_vault_secret" "kv-secret" {
  name                  = "gpitdevclientsecretkeyid"
  value                 = "werDcOTD/bvfl6zS=NzCIQX3jkGx5+4["
  content_type          = "GP IT Future Buying Catalogue Service Prinicpal Secret"
  key_vault_id          = "${azurerm_key_vault.keyvault.id}"
  tags                  = {
    environment         = "${var.environment}"
  }
}

resource "azurerm_key_vault_secret" "kv-buser" {
  name                  = "gpitdevbastionadminusername"
  value                 = "gpitfurebastionadmin"
  content_type          = "GP IT Future Buying Catalogue bastion host username"
  key_vault_id          = "${azurerm_key_vault.keyvault.id}"
  tags                  = {
    environment         = "${var.environment}"
  }
}

resource "azurerm_key_vault_secret" "kv-bpass" {
  name                  = "gpitdevbastionadminpassword"
  value                 = "Wmbivefdzxjkahclsgnrwytopq3508/a"
  content_type          = "GP IT Future Buying Catalogue bastion host password"
  key_vault_id          = "${azurerm_key_vault.keyvault.id}"
  tags                  = {
    environment         = "${var.environment}"
  }
}

resource "azurerm_key_vault_secret" "kv-sqluser" {
  name                  = "gpitdevsqladminusername"
  value                 = "gpitfutureadmin"
  content_type          = "GP IT Future Buying Catalogue bastion host password"
  key_vault_id          = "${azurerm_key_vault.keyvault.id}"
  tags                  = {
    environment         = "${var.environment}"
  }
}

resource "azurerm_key_vault_secret" "kv-sqlpass" {
  name                  = "gpitdevsqladminpassword"
  value                 = "Apguvltjcsamqyobnrxwfehdzk3750pk"
  content_type          = "GP IT Future Buying Catalogue bastion host password"
  key_vault_id          = "${azurerm_key_vault.keyvault.id}"
  tags                  = {
    environment         = "${var.environment}"
  }
}

resource "azurerm_key_vault_secret" "kv-sppass" {
  name                  = "gpitdevsharepointpassword"
  value                 = "Apguvltjcsamqyobnrxwfehdzk3750pk"
  content_type          = "GP IT Future Buying Catalogue SharePoint Online password"
  key_vault_id          = "${azurerm_key_vault.keyvault.id}"
  tags                  = {
    environment         = "${var.environment}"
  }
}

resource "azurerm_key_vault_secret" "kv-spuser" {
  name                  = "gpitdevsharepointusername"
  value                 = "buying.catalogue@nhs.net"
  content_type          = "GP IT Future Buying Catalogue SharePoint Online user"
  key_vault_id          = "${azurerm_key_vault.keyvault.id}"
  tags                  = {
    environment         = "${var.environment}"
  }
}