# Store Terraform state in Azure Storage
> https://learn.microsoft.com/en-us/azure/developer/terraform/store-state-in-azure-storage?source=recommendations&tabs=azure-cli
> https://learn.microsoft.com/en-us/azure/storage/common/storage-network-security?tabs=azure-portal


## 1.Configure remote state storage account

Édit file `create-remote-storage.tf` then

```
terraform init -upgrade
```

```
terraform plan -out main.tfplan
```

then

```
terraform apply main.tfplan
```

## 2.Create a Terraform configuration with a `backend` configuration block
Edit file `state-secure.tf` with

```
terraform {

  backend "azurerm" {
      resource_group_name  = "tfstate"
      storage_account_name = "<storage_account_name>"
      container_name       = "tfstate"
      key                  = "terraform.tfstate"
  }

}
```

"<storage_account_name>" is the name of the storage account you recently create in the first step.

## Clean up resources

```
terraform plan -destroy -out main.destroy.tfplan
```
then

```
terraform apply main.destroy.tfplan
```