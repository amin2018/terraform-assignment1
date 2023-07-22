resource "azurerm_availability_set" "win_vm_avs" {
  name                         = var.win_avs
  location                     = var.rgroup_location
  resource_group_name          = var.rgroup_name
  platform_update_domain_count = 5
  tags = {
    environment = "prod"
  }
}

resource "azurerm_windows_virtual_machine" "windows_vm" {
  name                = each.key
  computer_name       = each.key
  for_each            = var.windows_vm_name
  resource_group_name = var.rgroup_name
  location            = var.rgroup_location
  size                = each.value
  admin_username      = var.win_admin_username
  admin_password      = var.win_admin_password

  tags = {
    Assignment = "CCGC 5502 Automation Assignment"
    Name = "mohammed.hossain"
    ExpirationDate = "2024-12-31"
    Environment = "Learning"
  }

  winrm_listener {
    protocol = "Http"
  }

  network_interface_ids = [
    azurerm_network_interface.win_network_interface[each.key].id
  ]
  depends_on = [
    azurerm_availability_set.win_vm_avs
  ]
  os_disk {
    name                 = each.key
    caching              = var.win_vm_os_disk_attr["os-disk-Caching"]
    storage_account_type = var.win_vm_os_disk_attr["os-storage-account-type"]
    disk_size_gb         = var.win_vm_os_disk_attr["os-disk-size"]
  }
  source_image_reference {
    publisher = var.win_vm_source_image_info["os-publisher"]
    offer     = var.win_vm_source_image_info["os-offer"]
    sku       = var.win_vm_source_image_info["os-sku"]
    version   = var.win_vm_source_image_info["os-version"]
  }

    boot_diagnostics {
    storage_account_uri = var.storage_acc.primary_blob_endpoint
  }
}

resource "azurerm_network_interface" "win_network_interface" {
  for_each            = var.windows_vm_name
  name                = "${each.key}-nic"
  location            = var.rgroup_location
  resource_group_name = var.rgroup_name

  tags = {
    Assignment = "CCGC 5502 Automation Assignment"
    Name = "mohammed.hossain"
    ExpirationDate = "2024-12-31"
    Environment = "Learning"
  }

  ip_configuration {
    name                          = "${each.key}-nic"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.win_public_ip[each.key].id

  }
}

resource "azurerm_public_ip" "win_public_ip" {
  name                = "${each.key}-public-ip"
  for_each            = var.windows_vm_name
  resource_group_name = "n01594911-RG"
  location            = var.rgroup_location
  allocation_method   = "Dynamic"
  domain_name_label   = "terraform-assignment-${lower(replace(each.key, "/[^a-z0-9-]/", ""))}"
  
  tags = {
    Assignment = "CCGC 5502 Automation Assignment"
    Name = "mohammed.hossain"
    ExpirationDate = "2024-12-31"
    Environment = "Learning"
  }
}

resource "azurerm_virtual_machine_extension" "win_vm_extension" {
  for_each                   = var.windows_vm_name
  name                       = "IaaSAntimalware"
  publisher                  = "Microsoft.Azure.Security"
  type                       = "IaaSAntimalware"
  type_handler_version       = "1.3"
  auto_upgrade_minor_version = "true"
  virtual_machine_id         = azurerm_windows_virtual_machine.windows_vm[each.key].id

  settings = <<SETTINGS
    {
        "AntimalwareEnabled": true,
        "RealtimeProtectionEnabled": "true",
        "ScheduledScanSettings": {
            "isEnabled": "true",
            "day": "1",
            "time": "120",
            "scanType": "Quick"
            },
        "Exclusions": {
            "Extensions": "",
            "Paths": "",
            "Processes": ""
            }
    }
SETTINGS
}

