output "resource_group_name" {
  value = module.rgroup.resource_group_name.name
}

output "resource_group_location" {
  value = module.rgroup.resource_group_location.location
}

output "virtual_network_subnet_name" {
  value = module.network.virtual_network_subnet_name.name
}

output "virtual_network_name" {
  value = module.network.virtual_network_name.name
}

output "virtual_network_address_space" {
  value = module.network.virtual_network_name.address_space
}

output "virtual_network_sg_name" {
  value = module.network.virtual_network_sg_name.name
}


output "log_analytics_workspace_name" {
  value = module.common.log_analytics_workspace_name.name
}

output "rsv_name" {
  value = module.common.rsv_name.name
}

output "storage_acc_name" {
  value = module.common.storage_acc_name.name
}

output "linux_vm_private_ip" {
  value = module.linux.linux_vm_private_ip
}

output "linux_public_ip" {
  value = module.linux.linux_public_ip
}

output "linux_vm" {
  value = module.linux.linux_vm
}

output "linux_vm_hostname" {
  value = module.linux.linux_vm_hostname
}

output "windows_vm_hostname" {
  value = module.windows.windows_vm_hostname
}

output "windows_public_ip" {
  value = module.windows.windows_public_ip
}

output "windows_private_ip" {
  value = module.windows.windows_private_ip
}


output "db_name" {
  value = module.database.db_name.name
}
