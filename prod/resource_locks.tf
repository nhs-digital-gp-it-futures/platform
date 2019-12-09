resource "azurerm_management_lock" "storage" {
  name                              = "lock_storage_account"
  scope                             = "/subscriptions/7b12a8a2-f06f-456f-b6f9-aa2d92e0b2ec/resourceGroups/gpitfutures-prod-rg-sa"
  lock_level                        = "CanNotDelete"
  notes                             = "This resource group has been set to DoNotDelete to prevent terraform tfstate files and static content from being deleted"
}