#The Terraform tfstate file is currently being stored in an Azure storage container.
#Storage account name: gpitfuturesatf within the GP IT Futures Buying Catalogue subscription

terraform {
  required_version = ">= 0.12"
}

provider "azurerm" {
  version = "=1.37.0"
}

terraform {
  backend "azurerm" {
    resource_group_name  = "gpitfuture-sa-tf"
    storage_account_name = "gpitfuturesatf"
    container_name       = "terraform"
    key                  = "test.terraform.tfstate"
  }
}