output "resource_group_name" {
  description = "The name of the resource group"
  value       = azurerm_resource_group.rg.name
}

output "public_ip_address" {
  value = azurerm_linux_virtual_machine.my_terraform_vm.public_ip_address
}

output "public_ip_address_perplexity" {
  description = "The public IP address of the VM"
  value       = azurerm_public_ip.my_terraform_public_ip.ip_address
}

output "virtual_network_id" {
  description = "The ID of the virtual network"
  value       = azurerm_virtual_network.my_terraform_network.id
}

output "subnet_id" {
  description = "The ID of the subnet"
  value       = azurerm_subnet.my_terraform_subnet.id
}

output "network_interface_id" {
  description = "The ID of the network interface"
  value       = azurerm_network_interface.my_terraform_nic.id
}

output "vm_id" {
  description = "The ID of the virtual machine"
  value       = azurerm_linux_virtual_machine.my_terraform_vm.id
}

output "ssh_login_command" {
  description = "Command to log into the VM via SSH"
  value       = "ssh -i <path_to_your_private_key> ${var.username}@${azurerm_public_ip.my_terraform_public_ip.ip_address}"
}

output "vm_login_instructions" {
  value = <<EOT
To log into your VM, follow these steps:

1. Ensure your private key has the correct permissions:
   chmod 600 ~/.ssh/id_rsa

2. Use the following command to SSH into your VM:
   ssh -i ~/.ssh/id_rsa ${var.username}@${azurerm_public_ip.my_terraform_public_ip.ip_address}

Note: Replace ~/.ssh/id_rsa with the actual path to your private key if different.
EOT
}