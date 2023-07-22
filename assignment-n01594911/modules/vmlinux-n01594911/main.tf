resource "azurerm_availability_set" "linux_avs" {
  name                         = var.linux_vm_avs
  location                     = var.rgroup_location
  resource_group_name          = var.rgroup_name
  platform_update_domain_count = 5
  platform_fault_domain_count  = var.nb_count
  tags = {
    environment = "prod"
  }                        
}

resource "azurerm_network_interface" "linux_vm_network_interface" {
  count               = var.nb_count
  name                = "${var.linux_vm_name}-nic${format("%1d", count.index + 1)}"
  location            = var.rgroup_location
  resource_group_name = var.rgroup_name


  ip_configuration {
    name                          = "${var.linux_vm_name}1-ipconfig1${format("%1d", count.index + 1)}"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = element(azurerm_public_ip.linux_public_ip[*].id, count.index + 1)
  }
  
  tags = {
    Assignment = "CCGC 5502 Automation Assignment"
    Name = "mohammed.hossain"
    ExpirationDate = "2024-12-31"
    Environment = "Learning"
  }
}

resource "azurerm_public_ip" "linux_public_ip" {
  count                   = var.nb_count
  name                    = "${var.linux_vm_name}-pip${format("%1d", count.index + 1)}"
  resource_group_name     = var.rgroup_name
  location                = var.rgroup_location
  allocation_method       = "Dynamic"
  domain_name_label       = "domain1-${lower(replace(var.linux_vm_name, "/[^a-zA-Z0-9-]/", ""))}-${format("%1d", count.index + 1)}"
  idle_timeout_in_minutes = 30

  tags = {
    Assignment = "CCGC 5502 Automation Assignment"
    Name = "mohammed.hossain"
    ExpirationDate = "2024-12-31"
    Environment = "Learning"
  }
}

resource "azurerm_linux_virtual_machine" "vm_linux" {
  count               = var.nb_count
  name                = "${var.linux_vm_name}${format("%1d", count.index + 1)}"
  computer_name       = "${var.linux_vm_name}${format("%1d", count.index + 1)}"
  resource_group_name = var.rgroup_name
  location            = var.rgroup_location
  size                = var.linux_vm_size
  admin_username      = var.linux_admin_username
  availability_set_id = azurerm_availability_set.linux_avs.id
  tags = {
    Assignment = "CCGC 5502 Automation Assignment"
    Name = "mohammed.hossain"
    ExpirationDate = "2024-12-31"
    Environment = "Learning"
  }
  network_interface_ids = [
    element(azurerm_network_interface.linux_vm_network_interface[*].id, count.index + 1)

  ]
  depends_on = [
    azurerm_availability_set.linux_avs
  ]
  boot_diagnostics {
    storage_account_uri = var.storage_acc.primary_blob_endpoint
  }
  admin_ssh_key {
    username   = var.linux_admin_username
    public_key = file(var.linux_public_key)
  }
  os_disk {
    name                 = "${var.linux_vm_name}-os-disk${format("%1d", count.index + 1)}"
    caching              = var.linux_os_disk_attr["os-disk-caching"]
    storage_account_type = var.linux_os_disk_attr["os-storage-account-type"]
    disk_size_gb         = var.linux_os_disk_attr["os-disk-size"]
  }
  source_image_reference {
    publisher = var.linux_source_image_info["os-publisher"]
    offer     = var.linux_source_image_info["os-offer"]
    sku       = var.linux_source_image_info["os-sku"]
    version   = var.linux_source_image_info["os-version"]
  }
}

resource "azurerm_virtual_machine_extension" "linux_vm_network_watcher" {
  count                      = var.nb_count
  name                       = "linux_vm_network_watcher-${count.index + 1}"
  virtual_machine_id         = azurerm_linux_virtual_machine.vm_linux[count.index].id
  publisher                  = "Microsoft.Azure.NetworkWatcher"
  type                       = "NetworkWatcherAgentLinux"
  type_handler_version       = "1.4"
  auto_upgrade_minor_version = true

  tags = {
    Assignment = "CCGC 5502 Automation Assignment"
    Name = "mohammed.hossain"
    ExpirationDate = "2024-12-31"
    Environment = "Learning"
  }

  settings = <<SETTINGS
    {
      "xmlCfg": ""
    }
SETTINGS

  protected_settings = <<PROTECTED_SETTINGS
    {
      "storageAccountName": "${var.storage_acc_name}",
      "storageAccountKey": "${var.storage_acc_key.primary_access_key}"
    }
PROTECTED_SETTINGS
}

resource "azurerm_virtual_machine_extension" "azure_monitor" {
  count                      = var.nb_count
  name                       = "azure_monitor-${count.index + 1}"
  virtual_machine_id         = azurerm_linux_virtual_machine.vm_linux[count.index].id
  publisher                  = "Microsoft.Azure.Monitor"
  type                       = "AzureMonitorLinuxAgent"
  type_handler_version       = "1.0"
  auto_upgrade_minor_version = true

  tags = {
    Assignment = "CCGC 5502 Automation Assignment"
    Name = "mohammed.hossain"
    ExpirationDate = "2024-12-31"
    Environment = "Learning"
  }
  settings = <<SETTINGS
    {
    }
SETTINGS
}


