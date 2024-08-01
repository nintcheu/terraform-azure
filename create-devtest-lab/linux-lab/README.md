# Create a lab in Azure DevTest WINDOWS Labs using Terraform


## initialize

```
terraform fmt
```

```
terraform init -upgrade
```

## create execution plan

```
terraform plan -out main.tfplan
```

## Apply execution plan

```
terraform apply main.tfplan
```

## Verify the results

```
terraform output -raw resource_group_name
```

```
resource_group_name=$(terraform output -raw resource_group_name)
```

```
az lab vm list --resource-group $resource_group_name --lab-name $lab_name
```

## Clean up resources

```
terraform plan -destroy -out main.destroy.tfplan
```

```
terraform apply main.destroy.tfplan
```