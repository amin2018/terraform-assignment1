variable "windows_vm_name" {}

variable "subnet_id" {}

variable "rgroup_name" {}

variable "rgroup_location" {}

variable "win_nb_count" {}

variable "win_avs" { 
  default = "win_avs" 
}

variable "win_vm_os_disk_attr" {
  type = map(string)
  default = {
    os-storage-account-type = "StandardSSD_LRS"
    os-disk-size            = "128"
    os-disk-Caching         = "ReadWrite"
  }
}

variable "win_vm_source_image_info" {
  type = map(string)
  default = {
    os-publisher = "MicrosoftWindowsServer"
    os-offer     = "WindowsServer"
    os-sku       = "2016-Datacenter"
    os-version   = "latest"
  }
}

variable "win_admin_username" {
  default = "n01594911"
}

variable "win_admin_password" {
  default = "Amin@123"
}

variable "storage_acc" {}
