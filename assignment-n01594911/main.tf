module "rgroup" {
  source          = "./modules/rgroup-n01594911"
  rgroup_name     = "n01594911-RG"
  rgroup_location = "canada Central"
}

module "network" {
  source          = "./modules/network-n01594911"
  rgroup_name     = module.rgroup.resource_group_name.name
  rgroup_location  = module.rgroup.resource_group_location.location
  depends_on      = [
    module.rgroup
  ]
}

module "common" {
  source          = "./modules/common-n01594911"
  rgroup_name     = module.rgroup.resource_group_name.name
  rgroup_location = module.rgroup.resource_group_location.location
  subnet_id       = module.network.virtual_network_subnet_name
  depends_on      = [
    module.rgroup
  ]
}

module "linux" {
  source            = "./modules/vmlinux-n01594911"
  nb_count          = "3"
  linux_vm_name     = "vmlinux-n01594911"
  rgroup_name       = module.rgroup.resource_group_name.name
  rgroup_location   = module.rgroup.resource_group_location.location
  subnet_id         = module.network.virtual_network_subnet_name.id
  depends_on        = [
    module.rgroup,
    module.network,
    module.common
  ]
  storage_acc_name = module.common.storage_acc_name.name
  storage_acc_key  = module.common.storage_acc_key
  storage_acc    = module.common.storage_acc_name
}


module "windows" {
  source         = "./modules/vmwindows-n01594911"
  windows_vm_name  = {
    n01594911-vm1 = "Standard_B1s"
    n01594911-vm2 = "Standard_B1ms"
  }
  win_nb_count     = "1"
  subnet_id        = module.network.virtual_network_subnet_name.id
  rgroup_name      = module.rgroup.resource_group_name.name
  rgroup_location  = module.rgroup.resource_group_location.location
  storage_acc      = module.common.storage_acc_name
  depends_on       = [
    module.rgroup,
    module.network,
    module.common
  ]
}

module "datadisk" {
  source                   = "./modules/datadisk-n01594911"
  rgroup_name              = module.rgroup.resource_group_name.name
  rgroup_location          = module.rgroup.resource_group_location.location
  windows_vm_name          = module.windows.windows_vm_hostname
  win_vm_id                = module.windows.vm_win
  linux_vm_name            = module.linux.linux_vm_hostname
  linux_vm_id              = module.linux.linux_id
  depends_on               = [
    module.rgroup,
    module.linux,
    module.windows
  ]
}
module "loadbalancer" {
  source           = "./modules/loadbalancer-n01594911"
  rgroup_name      = module.rgroup.resource_group_name.name
  rgroup_location  = module.rgroup.resource_group_location.location
  linux_vm_public_ip  = module.linux.linux_public_ip
  linux_nic_id     = module.linux.linux_vm_nic_id[0]
  nb_count         = "1"
  linux_vm_name    = module.linux.linux_vm_hostname
  subnet_id        = module.network.virtual_network_subnet_name
  depends_on       = [
    module.rgroup,
    module.linux,
  ]
}


module "database" {
  source      = "./modules/database-n01594911"
  rgroup_name     = module.rgroup.resource_group_name.name
  rgroup_location = module.rgroup.resource_group_location.location
  depends_on = [
    module.rgroup
  ]
}