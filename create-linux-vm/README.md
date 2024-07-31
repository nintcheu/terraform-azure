# Use Terraform to create a Linux VM

> https://learn.microsoft.com/en-us/azure/virtual-machines/linux/quick-create-terraform?tabs=azure-cli


This diagram provides a basic structure that represents:
The main Terraform configuration
- Provider block
- Variables
- Resources (with examples)
- Outputs
- Modules (if used)
The arrows indicate relationships and flow between different components. This structure can be adapted based on the specific contents of your Terraform configuration file.

```
+------------------------+
|  Terraform Config      |
+------------------------+
| - version              |
+------------------------+
           |
           |
   +-------+-------+
   |               |
   v               v
+------------+ +--------------+
|  Provider  | |  Variables   |
+------------+ +--------------+
| - name     | | - var1: type |
| - version  | | - var2: type |
| - region   | +--------------+
+------------+
       |
       |
       v
+------------------+
|    Resources     |
+------------------+
| + aws_instance   |
| + aws_s3_bucket  |
| + aws_vpc        |
+------------------+
       |
       |
       v
+------------------+
|     Outputs      |
+------------------+
| - output1: value |
| - output2: value |
+------------------+
       |
       |
       v
+------------------+
|     Modules      |
+------------------+
| + module1        |
|   - input1       |
|   - output1      |
| + module2        |
|   - input2       |
|   - output2      |
+------------------+
```


Based on your Terraform configuration `main.tf` file, here's a UML-like representation of the resources and their relationships:
```
+------------------------+
|     random_pet         |
+------------------------+
| - prefix               |
+------------------------+
           |
           v
+------------------------+
| azurerm_resource_group |
+------------------------+
| - location             |
| - name                 |
+------------------------+
           |
           |
   +-------+-------+
   |               |
   v               v
+------------------------+  +------------------------+
| azurerm_virtual_network|  |    azurerm_subnet      |
+------------------------+  +------------------------+
| - name                 |  | - name                 |
| - address_space        |  | - address_prefixes     |
+------------------------+  +------------------------+
           |                           |
           |                           |
   +-------+-------+           +-------+
   |               |           |
   v               v           v
+------------------------+  +------------------------+
|   azurerm_public_ip    |  |azurerm_network_security|
+------------------------+  |        _group          |
| - name                 |  +------------------------+
| - allocation_method    |  | - name                 |
+------------------------+  | - security_rule        |
           |                +------------------------+
           |                           |
           v                           |
+------------------------+             |
|azurerm_network_interface|<-----------+
+------------------------+
| - name                 |
| - ip_configuration     |
+------------------------+
           |
           |
   +-------+-------+
   |               |
   v               v
+------------------------+  +------------------------+
|     random_id          |  | azurerm_storage_account|
+------------------------+  +------------------------+
| - keepers              |  | - name                 |
| - byte_length          |  | - account_tier         |
+------------------------+  | - account_replication  |
                            +------------------------+
                                        |
                                        v
                            +------------------------+
                            |azurerm_linux_virtual   |
                            |        _machine        |
                            +------------------------+
                            | - name                 |
                            | - size                 |
                            | - os_disk              |
                            | - source_image_reference|
                            | - admin_ssh_key        |
                            | - boot_diagnostics     |
                            +------------------------+
```

## initialize configuration

```
terraform init -upgrade
```

## Create execution plan

```
terraform plan -out main.tfplan
```

## Apply executtion plan
```
terraform apply main.tfplan
```


### outputs
```
key_data = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQClCJYbF9qOzfDODIKewuHdQJ66gQQNq0shAAruRBYxz6LqYFAT6BW3fl7pvFcjMjB59ZFd25JXDFUeta6mw3P+b1TZlmDhqgt4hKAx+7GwnEM1qc79aDyX6X9x8IQtGLUYXFP7LUz/0NdRW99y9YyO+ESLw0t0LVcI/D7/ILjwQW71Ez2O/fdy+BEi9KWsQC1Br6sZLDk2b1nBBPjr1bbhsrQA/vZmvoHxN8F+7WjMOq1KI8RX/gD5tPSvCUi9zicpscgQYUhROibL79zptr66YuX9Lrwwy+HyqTTFYfXpmFVpFR0Gs5qXDUWKNqQetY1hz6qgC24wvhDVQ7gTKt+WmIjqUDPuuHZCnAr3dBtkrjPVdFlQLM8wSfNUzRlBJ5RZh4VgsY73Y2wHh6H1qgwhC6VZQqWDnXtvbi6IdfAIkOGqDjs9gsyYG1Or6JrsYBuJHo5+uWaR4QSD5+UZpAboH39yoY/VriNSv8lZPpa/JEJLqhdBwCiPW54DenxokSk= generated-by-azure"
public_ip_address = "40.87.51.13"
resource_group_name = "rg-exact-bengal"
```

## Verify result

```
terraform output -raw resource_group_name
```

```
resource_group_name=$(terraform output -raw resource_group_name)
```

```
az vm list --resource-group $resource_group_name --query "[].{\"VM Name\":name}" -o table
```


## Clean up

```
terraform plan -destroy -out main.destroy.tfplan
```

```
terraform apply main.destroy.tfplan
```
