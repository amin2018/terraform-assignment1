variable "rgroup_name" {}

variable "rgroup_location" {}

variable "recovery_service_vault" {
  type                  = map(string)
  default               = {
    recovery_vault_name = "my-recovery-service-vault"
    recovery_sku        = "Standard"
  }
 }

variable "storage_account_tier" {
  default = "Standard"
}

variable "storage_account_replication" {
  default = "LRS"
}

variable "subnet_id" {}

