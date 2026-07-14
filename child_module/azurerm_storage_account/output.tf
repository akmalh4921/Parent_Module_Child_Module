output "storage_account_id" {
  description = "Map of storage account resource IDs"

  value = {
    for key, storage_account in azurerm_storage_account.stg :
    key => storage_account.id
  }
}