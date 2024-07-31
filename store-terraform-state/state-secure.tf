terraform {

  backend "azurerm" {
      resource_group_name  = "tfstate"
      storage_account_name = "tfstatefe4xp"
      container_name       = "tfstate"
      key                  = "terraform.tfstate"
  }

}

resource "azurerm_resource_group" "state-demo-secure" {
  name     = "state-demo"
  location = "eastus"
}