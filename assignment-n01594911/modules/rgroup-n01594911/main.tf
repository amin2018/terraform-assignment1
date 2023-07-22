resource "azurerm_resource_group" "rgroup" {
  name                = var.rgroup_name
  location            = var.rgroup_location
  
  tags = {
    Assignment = "CCGC 5502 Automation Assignment"
    Name = "mohammed.hossain"
    ExpirationDate = "2024-12-31"
    Environment = "Learning"
  }
}

