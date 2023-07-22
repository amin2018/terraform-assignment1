variable "rgroup_name" {
  description = "resource group name"
  type        = string
  default     = "4911-rg"
}

variable "rgroup_location" {
  description = "resource group location"
  type        = string
  default     = "Canada Central"
}

variable "vnet_address" {
  description = "virtual network"
  type        = list(string)
 default     = ["10.0.0.0/16"]

}

variable "subnet_address" {
  description = "subnet"
  type        = list(string)
 default     = ["10.0.0.0/24"]

}


