output "vnet_ids" {
  value = {
    for key, vnet in azurerm_virtual_network.vnet : key => vnet.id 
  }
}

