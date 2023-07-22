output "log_analytics_workspace_name" {
    value  = azurerm_log_analytics_workspace.log_analytics_workspace
}
output "rsv_name" {
    value = azurerm_recovery_services_vault.rsv
}
output "storage_acc_name" {
    value = azurerm_storage_account.st_acc
}
output "storage_acc_key" {
    value = azurerm_storage_account.st_acc
}
