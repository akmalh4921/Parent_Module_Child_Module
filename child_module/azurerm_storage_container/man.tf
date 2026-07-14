resource "azurerm_storage_container" "ctnr" {
  for_each = var.ctnr

  name = each.value.name
  storage_account_id = each.value.storage_account_id.id
  container_access_type = each.value.container_access_type
}
