#The Terraform tfstate file is currently being stored in an Azure storage container.
#Storage account name: gpitfuturesatf within the GP IT Futures Buying Catalogue subscription
terraform {
  backend "azurerm" {
    resource_group_name   = "gpitfuture-sa-tf"
    storage_account_name  = "gpitfuturesatf"
    container_name        = "terraform"
    key                   = "test.terraform.tfstate"
  }
}