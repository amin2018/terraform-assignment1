
variable "rgroup_name" {}

variable "rgroup_location" {}

variable "linux_vm_avs" { 
  default = "linux_availability_set" 
}

variable "nb_count" {}

variable "linux_vm_name" {}

variable "linux_vm_size" {
  default = "Standard_B1s"
}

variable "linux_private_key" {
  default = "C:\\Users\\Owner\\.ssh\\id_rsa"
}

variable "linux_admin_username" {
  default = "n01594911"
}

variable "linux_public_key" {
  default = "C:\\Users\\Owner\\.ssh\\id_rsa.pub"
}

variable "linux_os_disk_attr" {
  type = map(string)
  default = {
    os-storage-account-type = "Premium_LRS"
    os-disk-size            = "32"
    os-disk-caching         = "ReadWrite"
  }
}

variable "linux_source_image_info" {
  type = map(string)
  default = {
    os-publisher = "OpenLogic"
    os-offer     = "CentOS"
    os-sku       = "8_2"
    os-version   = "latest"
  }
}


variable "storage_acc_name" {}

variable "storage_acc_key" {}

variable "storage_acc" {}

variable "subnet_id" {}



