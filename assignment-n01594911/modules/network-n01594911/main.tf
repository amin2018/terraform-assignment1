resource "azurerm_virtual_network" "vnet" {
  name                = "n01594911-VNET"
  location            = var.rgroup_location
  resource_group_name = var.rgroup_name
  address_space       = var.vnet_address

  tags = {
    Assignment     = "CCGC 5502 Automation Assignment"
    Name           = "mohammed.hossain"
    ExpirationDate = "2024-12-31"
    Environment    = "Learning"
  }
}

resource "azurerm_subnet" "vnet_subnet" {
  name                 = "n01594911-SUBNET"
  resource_group_name  = var.rgroup_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.subnet_address
}

resource "azurerm_network_security_group" "nsg" {
  name                = "n01594911-NSG"
  location            = var.rgroup_location
  resource_group_name = var.rgroup_name

  security_rule {
    name                       = "AllowSSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "ALLOWRDP"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowWinRM"
    priority                   = 102
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5985"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowHTTP"
    priority                   = 103
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "nsg_association" {
  subnet_id                 = azurerm_subnet.vnet_subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}
