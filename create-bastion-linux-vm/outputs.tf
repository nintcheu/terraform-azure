output "resource_group_name" {
  value = azurerm_resource_group.rg.name
  description = "The name of the resource group where Azure Bastion is deployed."
}

output "bastion_public_ip" {
  value = azurerm_public_ip.bastion_public_ip.ip_address
  description = "The public IP address of Azure Bastion."
}

output "bastion_fqdn" {
  value = azurerm_public_ip.bastion_public_ip.fqdn
  description = "The fully qualified domain name of Azure Bastion."
}

output "virtual_machine_name" {
  value = azurerm_linux_virtual_machine.my_terraform_vm.name
  description = "The name of the virtual machine."
}

output "virtual_machine_private_ip" {
  value = azurerm_network_interface.my_terraform_nic.private_ip_address
  description = "The private IP address of the virtual machine."
}

output "bastion_connection_instructions" {
  value = <<EOF
To connect to your VM using Azure Bastion:
1. Go to the Azure Portal (https://portal.azure.com)
2. Navigate to the virtual machine '${azurerm_linux_virtual_machine.my_terraform_vm.name}'
3. Click on 'Connect' and select 'Bastion'
4. Use the username '${var.username}' and your SSH key for authentication
5. Click 'Connect' to access your VM through Bastion

Note: Ensure you have the necessary permissions to use Azure Bastion.
EOF
  description = "Instructions for connecting to the VM using Azure Bastion."
}

