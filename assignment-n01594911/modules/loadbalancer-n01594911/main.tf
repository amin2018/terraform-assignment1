resource "azurerm_public_ip" "load_balancer_public_ip" {
  name                       = "PublicIPForLB"
  location                   = var.rgroup_location
  resource_group_name        = var.rgroup_name
  allocation_method          = "Static"

  tags = {
    Assignment = "CCGC 5502 Automation Assignment"
    Name = "mohammed.hossain"
    ExpirationDate = "2024-12-31"
    Environment = "Learning"
  }
}

resource "azurerm_lb" "linux_vm_lb" {
  name                     = "linux_lb"
  location                 = var.rgroup_location
  resource_group_name      = var.rgroup_name
  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.load_balancer_public_ip.id
  }

   tags = {
    Assignment = "CCGC 5502 Automation Assignment"
    Name = "mohammed.hossain"
    ExpirationDate = "2024-12-31"
    Environment = "Learning"
  }
}

resource "azurerm_lb_backend_address_pool" "lb_pool" {
  loadbalancer_id = azurerm_lb.linux_vm_lb.id
  name            = "BackEndAddressPool"
}

resource "azurerm_network_interface_backend_address_pool_association" "lb_pool_association" {
  count                   = var.nb_count
  network_interface_id    = var.linux_nic_id[count.index]
  backend_address_pool_id = azurerm_lb_backend_address_pool.lb_pool.id
  ip_configuration_name   = "${replace(var.linux_vm_name[0], "vm1", "vm")}-ipconfig1${format("%1d", count.index + 1)}"
}

resource "azurerm_lb_rule" "lb_rule" {
  loadbalancer_id                = azurerm_lb.linux_vm_lb.id
  name                           = "LBRule"
  protocol                       = "Tcp"
  frontend_port                  = 22
  backend_port                   = 22
  frontend_ip_configuration_name = "PublicIPAddress"
}

