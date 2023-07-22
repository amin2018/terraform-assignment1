output "linux_vm_hostname" {
  value = azurerm_linux_virtual_machine.vm_linux[*].name
}

output "linux_id" {
  value = azurerm_linux_virtual_machine.vm_linux[*].id
}

output "liunx_vm_FQDN" {
  value = [azurerm_public_ip.linux_public_ip[*].fqdn]
}

output "linux_vm_private_ip" {
  value = [azurerm_linux_virtual_machine.vm_linux[*].private_ip_address]

}

output "linux_public_ip" {
  value = azurerm_linux_virtual_machine.vm_linux[*].public_ip_address
}

output "vm_linux_avs" {
  value = azurerm_availability_set.linux_avs.name
}

output "linux_vm" {
  value = [azurerm_linux_virtual_machine.vm_linux[*].name]
}

output "linux_vm_domain_label" {
  value = [azurerm_public_ip.linux_public_ip[*].domain_name_label]
}

output "linux_vm_nic_id" {
  value = [azurerm_network_interface.linux_vm_network_interface[*].id]

}
