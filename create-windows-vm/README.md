# Créer une machine virtuelle Windows

## initialize terraform

```
terraform fmt
```

```
terraform init -upgrade
```

## Prepare execution plan

```
terraform plan -out main.tfplan
```
## Apply execution plan

```
terraform apply main.tfplan
```

## Check the result
```
echo $(terraform output -raw public_ip_address)
```

## Plam for destruction

```
terraform plan -destroy -out main.destroy.tfplan
```

## Destroy 

```
terraform apply main.destroy.tfplan
```