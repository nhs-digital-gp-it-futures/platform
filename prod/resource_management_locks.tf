resource "azurerm_management_lock" "aks" {
    name            = "az_mgm_lock_aks"
    scope           = "${azurerm_resource_group.aks.id}"
    lock_level      = "CanNotDelete"
    notes           = "To prevent Production Resource Group from being deleted"
}

resource "azurerm_management_lock" "ehubuks" {
    name            = "az_mgm_lock_ehub_uks"
    scope           = "${azurerm_resource_group.ehubuks.id}"
    lock_level      = "CanNotDelete"
    notes           = "To prevent Production Resource Group from being deleted"
}

resource "azurerm_management_lock" "ehubukw" {
    name            = "az_mgm_lock_aks"
    scope           = "${azurerm_resource_group.ehubukw.id}"
    lock_level      = "CanNotDelete"
    notes           = "To prevent Production Resource Group from being deleted"
}

resource "azurerm_management_lock" "log_analytics" {
    name            = "az_mgm_lock_aks"
    scope           = "${azurerm_resource_group.log_analytics.id}"
    lock_level      = "CanNotDelete"
    notes           = "To prevent Production Resource Group from being deleted"
}

resource "azurerm_management_lock" "bc-sql-pri" {
    name            = "az_mgm_lock_aks"
    scope           = "${azurerm_resource_group.bc-sql-pri.id}"
    lock_level      = "CanNotDelete"
    notes           = "To prevent Production Resource Group from being deleted"
}

resource "azurerm_management_lock" "bc-sql-sec" {
    name            = "az_mgm_lock_aks"
    scope           = "${azurerm_resource_group.bc-sql-sec.id}"
    lock_level      = "CanNotDelete"
    notes           = "To prevent Production Resource Group from being deleted"
}

resource "azurerm_management_lock" "storage" {
    name            = "az_mgm_lock_aks"
    scope           = "${azurerm_resource_group.storage.id}"
    lock_level      = "CanNotDelete"
    notes           = "To prevent Production Resource Group from being deleted"
}

resource "azurerm_management_lock" "virtual_machine" {
    name            = "az_mgm_lock_aks"
    scope           = "${azurerm_resource_group.virtual_machine.id}"
    lock_level      = "CanNotDelete"
    notes           = "To prevent Production Resource Group from being deleted"
}

resource "azurerm_management_lock" "vnet" {
    name            = "az_mgm_lock_aks"
    scope           = "${azurerm_resource_group.vnet.id}"
    lock_level      = "CanNotDelete"
    notes           = "To prevent Production Resource Group from being deleted"
}