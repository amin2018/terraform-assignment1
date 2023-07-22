output "vmwin_avs" {
  value = azurerm_availability_set.win_vm_avs
}

output "vm_win" {
  value =  values(azurerm_windows_virtual_machine.windows_vm)[*].id
}

output "windows_vm_hostname" {
  value = [values(azurerm_windows_virtual_machine.windows_vm)[*].name]
}

output "windows_public_ip" {
  value = [values(azurerm_windows_virtual_machine.windows_vm)[*].public_ip_address]
}

output "windows_private_ip" {
  value = [values(azurerm_windows_virtual_machine.windows_vm)[*].private_ip_address]
}
