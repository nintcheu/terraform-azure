# Use Terraform to create a "Bastion" Linux VM 

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


Based on your updated main.tf file with the inclusion of Azure Bastion, here's a UML-like text-based representation of the resources and their relationships:
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
| - name                 |  | - name: mySubnet       |
| - address_space        |  | - address_prefixes     |
+------------------------+  +------------------------+
           |                           |
           |                           |
   +-------+-------+           +-------+
   |               |           |
   v               v           v
+------------------------+  +------------------------+
|azurerm_subnet          |  |azurerm_public_ip       |
| - name: AzureBastion   |  +------------------------+
| - address_prefixes     |  | - name: bastion-public |
+------------------------+  | - allocation_method    |
           |                +------------------------+
           |                           |
           v                           v
+------------------------+  +------------------------+
| azurerm_bastion_host   |  |azurerm_network_security|
+------------------------+  |        _group          |
| - name                 |  +------------------------+
| - ip_configuration     |  | - name                 |
+------------------------+  | - security_rule        |
           |                +------------------------+
           |
           v
+------------------------+
|azurerm_network_interface|
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

### Explanation
- random_pet: Generates a random name for the resource group.
- azurerm_resource_group: Defines the resource group.
- azurerm_virtual_network: Defines the virtual network.
- azurerm_subnet: Defines two subnets: one for general use and one specifically for Azure Bastion.
- azurerm_public_ip: Defines the public IP for Azure Bastion.
- azurerm_bastion_host: Configures the Azure Bastion host with the public IP and subnet.
- azurerm_network_security_group: Defines the network security group with security rules.
- azurerm_network_interface: Configures the network interface for the VM.
- random_id: Generates a unique ID for the storage account name.
- azurerm_storage_account: Defines the storage account for boot diagnostics.
- azurerm_linux_virtual_machine: Configures the Linux virtual machine.

This diagram illustrates the relationships and dependencies between the various Terraform resources in your configuration, including the addition of Azure Bastion for secure access.


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


## Verify result

Get the resource groupe
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
