output "virtual_network_subnet_name" {
  value = azurerm_subnet.vnet_subnet
}

output "virtual_network_sg_name" {
  value = azurerm_network_security_group.nsg
}

output "virtual_network_name" {
  value = azurerm_virtual_network.vnet
}


