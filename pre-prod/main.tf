#The Terraform tfstate file is currently being stored in an Azure storage container.
#Storage account name: gpitfuturesatf within the GP IT Futures Buying Catalogue subscription

provider "azurerm" {
  version = "=1.37.0"
}

terraform {
  backend "azurerm" {
    resource_group_name  = "gpitfutures-dev-rg-sa"
    storage_account_name = "gpitfuturessatf"
    container_name       = "tfstate"
    key                  = "pprod.terraform.tfstate"
  }
}