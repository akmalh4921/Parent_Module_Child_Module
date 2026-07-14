output "storage_account_ids" {
  value = {
    for key, storage_account in azurerm_storage_account.stg :
    key => storage_account.id
  }
}