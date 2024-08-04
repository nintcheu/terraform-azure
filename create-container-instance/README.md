# Create an Azure Container Instance with a public IP
> https://learn.microsoft.com/en-us/azure/container-instances/container-instances-quickstart-terraform


## Achitecture a of the lab

```
+-------------------+
| random_pet        |
| (rg_name)         |
+-------------------+
         |
         | id
         v
+-------------------+
| azurerm_resource  |
| _group (rg)       |
+-------------------+
         |
         | name, location
         v
+-------------------+     +-------------------+
| azurerm_container |     | random_string     |
| _group (container)|<----| (container_name)  |
+-------------------+     +-------------------+
         ^                         |
         |                         |
         +--------------------------
           uses for naming

Legend:
-----> : "references" or "depends on"
```

## Initialize terraform

```
terraform fmt
```

```
terraform init -upgrade
```

## Create execution plan

```
terraform plan -out main.tfplan
```

## Apply exection plan

```
terraform apply main.tfplan
```

## Verify the result

```
terraform output -raw container_ipv4_address
```

## Clean ressources

```
terraform plan -destroy -out main.destroy.tfplan
```

```
terraform apply main.destroy.tfplan
```