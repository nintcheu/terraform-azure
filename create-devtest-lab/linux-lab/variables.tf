variable "resource_group_location" {
  type        = string
  default     = "eastus"
  description = "Location for all resources."
}

variable "resource_group_name_prefix" {
  type        = string
  default     = "rg"
  description = "Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription."
}

variable "lab_name" {
  type        = string
  description = "The name of the new lab instance to be created"
  default     = "ExampleLab"
}

variable "vm_size_two_cpu" {
  type        = string
  description = "The size of the vm to be created. 2 cpu - 8GiB"
  default     = "Standard_D2s_v3"
}

variable "vm_size_four_cpu" {
  type        = string
  description = "The size of the vm to be created. 4 cpu - 16 GiB"
  default     = "Standard_D4_v3"
}

variable "user_name" {
  type        = string
  description = "The username for the local account that will be created on the new vm."
  default     = "exampleuser"
}

variable "password" {
  type        = string
  description = "The password for the local account that will be created on the new vm."
  sensitive   = true
  default     = null
}

variable "ssh_public_key_path" {
  default = "~/.ssh/id_rsa.pub"
  type    = string
}

variable "ssh_private_key_path" {
  default = "~/.ssh/id_rsa"
  type    = string
}