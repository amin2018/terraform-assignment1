variable "prefix" {
  default = "n01594911"
}

locals {
  vm_name = "${var.prefix}-vm"
}

variable "rgroup_name" {}

variable "rgroup_location" {}

variable "windows_vm_name" {}

variable "win_vm_id" {} 

variable "linux_vm_name" {}

variable "linux_vm_id" {}

variable "count_vm" {
  default="4"
}