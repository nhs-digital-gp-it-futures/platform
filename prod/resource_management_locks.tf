resource "azurerm_management_lock" "acr" {
    name            = "az_mgm_lock_aks"
    scope           = "/subscriptions/d1be8dbc-1a9f-4b7b-ba51-037116110e00/resourceGroups/gpitfutures-prod-rg-acr"
    lock_level      = "CanNotDelete"
    notes           = "To prevent Production Resource Group from being deleted"
}

resource "azurerm_management_lock" "aks" {
    name            = "az_mgm_lock_aks"
    scope           = "/subscriptions/d1be8dbc-1a9f-4b7b-ba51-037116110e00/resourceGroups/gpitfutures-prod-rg-aks"
    lock_level      = "CanNotDelete"
    notes           = "To prevent Production Resource Group from being deleted"
}

resource "azurerm_management_lock" "akspool" {
    name            = "az_mgm_lock_aks_pool"
    scope           = "/subscriptions/d1be8dbc-1a9f-4b7b-ba51-037116110e00/resourceGroups/gpitfutures-prod-rg-akspool"
    lock_level      = "CanNotDelete"
    notes           = "To prevent Production Resource Group from being deleted"
}

resource "azurerm_management_lock" "ehubuks" {
    name            = "az_mgm_lock_ehub_uks"
    scope           = "/subscriptions/d1be8dbc-1a9f-4b7b-ba51-037116110e00/resourceGroups/gpitfutures-prod-rg-ehub-uks"
    lock_level      = "CanNotDelete"
    notes           = "To prevent Production Resource Group from being deleted"
}

resource "azurerm_management_lock" "ehubukw" {
    name            = "az_mgm_lock_aks"
    scope           = "/subscriptions/d1be8dbc-1a9f-4b7b-ba51-037116110e00/resourceGroups/gpitfutures-prod-rg-ehub-ukw"
    lock_level      = "CanNotDelete"
    notes           = "To prevent Production Resource Group from being deleted"
}

resource "azurerm_management_lock" "log_analytics" {
    name            = "az_mgm_lock_aks"
    scope           = "/subscriptions/d1be8dbc-1a9f-4b7b-ba51-037116110e00/resourceGroups/gpitfutures-prod-rg-la"
    lock_level      = "CanNotDelete"
    notes           = "To prevent Production Resource Group from being deleted"
}

resource "azurerm_management_lock" "bc-sql-pri" {
    name            = "az_mgm_lock_aks"
    scope           = "/subscriptions/d1be8dbc-1a9f-4b7b-ba51-037116110e00/resourceGroups/gpitfutures-prod-rg-sql-pri"
    lock_level      = "CanNotDelete"
    notes           = "To prevent Production Resource Group from being deleted"
}

resource "azurerm_management_lock" "bc-sql-sec" {
    name            = "az_mgm_lock_aks"
    scope           = "/subscriptions/d1be8dbc-1a9f-4b7b-ba51-037116110e00/resourceGroups/gpitfutures-prod-rg-sql-sec"
    lock_level      = "CanNotDelete"
    notes           = "To prevent Production Resource Group from being deleted"
}

resource "azurerm_management_lock" "storage" {
    name            = "az_mgm_lock_aks"
    scope           = "/subscriptions/d1be8dbc-1a9f-4b7b-ba51-037116110e00/resourceGroups/gpitfutures-prod-rg-sa"
    lock_level      = "CanNotDelete"
    notes           = "To prevent Production Resource Group from being deleted"
}

resource "azurerm_management_lock" "virtual_machine" {
    name            = "az_mgm_lock_aks"
    scope           = "/subscriptions/d1be8dbc-1a9f-4b7b-ba51-037116110e00/resourceGroups/gpitfutures-prod-rg-vm"
    lock_level      = "CanNotDelete"
    notes           = "To prevent Production Resource Group from being deleted"
}

resource "azurerm_management_lock" "vnet" {
    name            = "az_mgm_lock_aks"
    scope           = "/subscriptions/d1be8dbc-1a9f-4b7b-ba51-037116110e00/resourceGroups/gpitfutures-prod-rg-vnet"
    lock_level      = "CanNotDelete"
    notes           = "To prevent Production Resource Group from being deleted"
}