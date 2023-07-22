resource "azurerm_managed_disk" "windows_data_disk" { 
  count                = length(var.windows_vm_name)
  name                 = "${var.windows_vm_name[0][0]}-data-disk${format("%1d", count.index + 1)}"

  location             = var.rgroup_location
  resource_group_name  = var.rgroup_name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = 10

  tags = {
    Assignment = "CCGC 5502 Automation Assignment"
    Name = "mohammed.hossain"
    ExpirationDate = "2024-12-31"
    Environment = "Learning"
  }
}

resource "azurerm_virtual_machine_data_disk_attachment" "windows_disk_management" {
  count              = length(var.windows_vm_name)
  managed_disk_id    = element(azurerm_managed_disk.windows_data_disk[*].id, count.index+1)
  virtual_machine_id = var.win_vm_id[count.index]
  lun                = "0"
  caching            = "ReadWrite"
    depends_on       = [
    azurerm_managed_disk.windows_data_disk
  ]
}

resource "azurerm_managed_disk" "linux_data_disk" {
  count                = length(var.linux_vm_name)
  name                 = "${var.linux_vm_name[0]}-data-disk${format("%1d", count.index + 1)}"
  location             = var.rgroup_location
  resource_group_name  = var.rgroup_name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = 10
  tags = {
    Assignment = "CCGC 5502 Automation Assignment"
    Name = "mohammed.hossain"
    ExpirationDate = "2024-12-31"
    Environment = "Learning"
  }
}

resource "azurerm_virtual_machine_data_disk_attachment" "linux_disk_management" {
  count              = length(var.linux_vm_name)
  managed_disk_id    = element(azurerm_managed_disk.linux_data_disk[*].id, count.index+1)
  virtual_machine_id = var.linux_vm_id[count.index]
  lun                = "0"
  caching            = "ReadWrite"
    depends_on       = [
    azurerm_managed_disk.linux_data_disk
  ]
}