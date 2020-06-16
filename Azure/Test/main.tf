#The Terraform tfstate file is currently being stored in an Azure storage container.
#Storage account name: gpitfuturesatf within the GP IT Futures Buying Catalogue subscription

terraform {
  required_version        = ">= 0.12"
}

provider "azurerm" {
  #version                = "2.7.0"
  version                = "2.10.0"
  features {
  }
}

terraform {
  backend "azurerm" {
    resource_group_name   = "gpitfutures-rg-sa"
    storage_account_name  = "gpitfuturessatf"
    container_name        = "tfstate"
    key                   = "test.terraform.tfstate"
  }
}