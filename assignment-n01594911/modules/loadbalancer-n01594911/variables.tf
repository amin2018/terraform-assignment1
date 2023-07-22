variable "rgroup_name" {}

variable "rgroup_location" {}

variable "linux_vm_public_ip" {}

variable "linux_nic_id" {
  type = list(string)
}

variable "nb_count" {}

variable "subnet_id" {}

variable  "linux_vm_name" {}
