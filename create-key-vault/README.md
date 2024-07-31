# Create an Azure key vault and key using Terraform

> https://learn.microsoft.com/en-us/azure/key-vault/keys/quick-create-terraform?tabs=azure-cli

## Initialize Terraform
```
terraform init -upgrade
```
> opt `-upgrade` : Opt to upgrade modules and plugins as part of their respective installation steps. See the sections below for more details
> source: https://developer.hashicorp.com/terraform/cli/commands/init

## Create a Terraform execution plan
```
terraform plan -out main.tfplan
```

## Apply a Terraform execution plan
```
terraform apply main.tfplan
```

## Verify the results

```
terraform output -raw azurerm_key_vault_name
```

### Get the Azure key vault name

```
azurerm_key_vault_name=$(terraform output -raw azurerm_key_vault_name)
```

### Display information about the key vault's keys

```
az keyvault key list --vault-name $azurerm_key_vault_name
```

## Clean up resources

### Plan the destruction

```
terraform plan -destroy -out main.destroy.tfplan
```

### Execute the destruction

```
terraform apply main.destroy.tfplan
```

# Learn more
> https://learn.microsoft.com/fr-fr/azure/key-vault/?WT.mc_id=Portal-Microsoft_Azure_KeyVault
> https://learn.microsoft.com/en-us/training/modules/manage-secrets-with-azure-key-vault/?source=recommendations