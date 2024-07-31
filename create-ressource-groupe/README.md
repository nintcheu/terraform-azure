
## 1.Initialize module

```
terraform init -upgrade
```

## Plan execution

```
terraform plan -out main.tfplan
```

## Execute

```
terraform apply main.tfplan
```


## Clean up resources

### Plan destroy
```
terraform plan -destroy -out main.destroy.tfplan
```

### Destroy

```
terraform apply main.destroy.tfplan
```