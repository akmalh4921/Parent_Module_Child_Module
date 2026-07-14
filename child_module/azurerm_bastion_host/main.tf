resource "azurerm_bastion_host" "bsn" {
  for_each            = var.bsn
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                 = each.value.ip_configuration.name
    subnet_id            = var.subnet_ids[each.value.subnet_key]
    public_ip_address_id = var.pip_ids[each.value.pip_key]
  }
}
