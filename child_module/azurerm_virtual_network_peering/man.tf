resource "azurerm_virtual_network_peering" "peering" {
  for_each = var.peering
  name                      = "peer-vnet-dev-04topeer-vnet-dev-05"
 resource_group_name       = each.value.resource_group_name
  virtual_network_name      = each.value.virtual_network_name
  remote_virtual_network_id = var.vnet_ids[each.value.vnet_key]
  

   allow_virtual_network_access = each.value.allow_virtual_network_access
}

