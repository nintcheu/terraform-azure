resource "random_pet" "rg_name" {
  prefix = var.resource_group_name_prefix
}

resource "random_string" "vm_suffix" {
  length  = 5
  upper   = false
  special = false
  numeric = false
}

resource "azurerm_resource_group" "rg" {
  name     = random_pet.rg_name.id
  location = var.resource_group_location
}


resource "azurerm_dev_test_lab" "lab" {
  name                = var.lab_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_dev_test_virtual_network" "vnet" {
  name                = "Dtl${var.lab_name}"
  lab_name            = azurerm_dev_test_lab.lab.name
  resource_group_name = azurerm_resource_group.rg.name
}

data "azurerm_subnet" "existing_subnet" {
  name                 = "Dtl${var.lab_name}Subnet"
  virtual_network_name = azurerm_dev_test_virtual_network.vnet.name
  resource_group_name  = azurerm_resource_group.rg.name
}

resource "azurerm_dev_test_linux_virtual_machine" "vm" {
  name                   = "ExampleVM-${random_string.vm_suffix.result}"
  lab_name               = azurerm_dev_test_lab.lab.name
  lab_subnet_name        = data.azurerm_subnet.existing_subnet.name
  resource_group_name    = azurerm_resource_group.rg.name
  location               = azurerm_resource_group.rg.location
  storage_type           = "Standard"
  size                   = var.vm_size_two_cpu
  username               = var.user_name
  ssh_key                = file(var.ssh_public_key_path)
  allow_claim            = false
  lab_virtual_network_id = azurerm_dev_test_virtual_network.vnet.id

  gallery_image_reference {
    offer     = "0001-com-ubuntu-server-jammy"
    publisher = "Canonical"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
}


resource "azurerm_network_security_group" "nsg" {
  name                = "nsg-${random_string.vm_suffix.result}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "AllowSSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }


  security_rule {
    name                       = "AllowHTTP"
    priority                   = 1003
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowHTTPS"
    priority                   = 1004
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "nsg_association" {
  subnet_id                 = data.azurerm_subnet.existing_subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_public_ip" "public_ip" {
  name                = "public-ip-${random_string.vm_suffix.result}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "nic" {
  name                = "nic-${random_string.vm_suffix.result}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.existing_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip.id
  }
}

