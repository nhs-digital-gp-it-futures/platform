terraform {
  backend "azurerm" {
    resource_group_name   = "gpitfuture-sa-tf"
    storage_account_name  = "gpitfuturesatf"
    container_name        = "terraform"
    key                   = "dev.aks.tfstate"
  }
}