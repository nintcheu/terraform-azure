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
Based on your Terraform configuration, I'll create a simplified UML-like diagram representing the relationships between the resources. Here's a textual representation of the diagram:

```
+------------------------+
|  random_pet: rg_name   |
+------------------------+
           |
           | generates name for
           v
+------------------------+
| azurerm_resource_group |
+------------------------+
           |
           | contains
           |------------------------+
           |                        |
           v                        v
+------------------------+  +------------------------+
| azurerm_virtual_network|  |  azurerm_public_ip     |
+------------------------+  +------------------------+
           |
           | contains
           v
+------------------------+
|    azurerm_subnet      |
+------------------------+
           |
           | associated with
           v
+------------------------+
|azurerm_network_interface|
+------------------------+
           |
           | associated with
           |
    +------+------+
    |             |
    v             v
+------------------------+  +------------------------+
|azurerm_network_security|  |azurerm_linux_virtual   |
|_group                  |  |_machine                |
+------------------------+  +------------------------+
    |                               |
    | associated with               | uses
    |                               |
    v                               v
+------------------------+  +------------------------+
|azurerm_network_interface|  |azurerm_storage_account|
|_security_group_assoc    |  +------------------------+
+------------------------+          ^
                                    |
                                    | uses
                                    |
                         +------------------------+
                         |      random_id         |
                         +------------------------+
```


This diagram shows:

- The random_pet resource generates a name for the azurerm_resource_group.
- The azurerm_resource_group contains the azurerm_virtual_network and azurerm_public_ip.
- The azurerm_virtual_network contains the azurerm_subnet.
- The azurerm_subnet is associated with the azurerm_network_interface.
- The azurerm_network_interface is associated with both the azurerm_network_security_group and the azurerm_linux_virtual_machine.
- The azurerm_network_security_group is associated with the azurerm_network_interface through the azurerm_network_interface_security_group_association.
- The azurerm_linux_virtual_machine uses the azurerm_storage_account.
- The random_id resource is used to generate a unique name for the azurerm_storage_account.

This diagram provides a visual representation of how your resources are related in your Terraform configuration, showing the dependencies and associations between different Azure resources.

## initialize configuration

```
terraform init -upgrade
```


## format my files *.tf

```
terraform fmt
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
vm_login_instructions = <<EOT
To log into your VM, follow these steps:

1. Ensure your private key has the correct permissions:
   chmod 600 ~/.ssh/id_rsa

2. Use the following command to SSH into your VM:
   ssh -i ~/.ssh/id_rsa azureadmin@

Note: Replace ~/.ssh/id_rsa with the actual path to your private key if different.

EOT
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
