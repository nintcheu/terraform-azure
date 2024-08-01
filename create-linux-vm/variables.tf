variable "resource_group_location" {
  type        = string
  default     = "eastus"
  description = "Location of the resource group."
}

variable "resource_group_name_prefix" {
  type        = string
  default     = "rg"
  description = "Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription."
}

variable "username" {
  type        = string
  description = "The username for the local account that will be created on the new VM."
  default     = "azureadmin"
}

variable "virtual_network_name" {
  type        = string
  description = "The name of my virtual network"
  default     = "myVnet"
}

variable "virtual_subnet_name" {
  type        = string
  description = "The name of my virtual subnet"
  default     = "mySubnet"
}

variable "network_interface_name" {
  type        = string
  description = "The name of my network interface "
  default     = "myNIC"
}

variable "virtual_machine_name" {
  type        = string
  description = "The name of my VM"
  default     = "myVM"
}


variable "virtual_machine_hostname" {
  type        = string
  description = "The value to write inside the /etc/hostname"
  default     = "crxxxvm"
}

variable "label_public_ip" {
  type        = string
  description = "Label for public IP"
  default     = "myPublicIP"
}

variable "label_security_group" {
  type        = string
  description = "Label to name network security group"
  default     = "myNetworkSecurityGroup"
}

variable "label_nic" {
  type        = string
  description = "Label to name nic - network interface configuration"
  default     = "my_nic_configuration"
}