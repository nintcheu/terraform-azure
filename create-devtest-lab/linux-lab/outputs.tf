output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "vm_name" {
  value = azurerm_dev_test_linux_virtual_machine.vm.name
}



output "ssh_command" {
  description = "SSH command to connect to the VM"
  value       = "ssh -i ${var.ssh_private_key_path} ${var.user_name}@${azurerm_dev_test_linux_virtual_machine.vm.name}"
}