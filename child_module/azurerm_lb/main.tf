resource "azurerm_lb" "lb" {
    for_each = var.load_balancer

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
   sku = each.value.sku

  frontend_ip_configuration {
    name                 = each.value.frontend_ip_configuration.name
    public_ip_address_id = var.pip_ids[each.value.frontend_ip_configuration.pip_key]
  }
}

resource "azurerm_lb_backend_address_pool" "bpool" {
    for_each = var.backend_pool

   loadbalancer_id = azurerm_lb.lb[each.value.lb_key].id
  name            = each.value.name
}

resource "azurerm_lb_probe" "lbprobe" {
    for_each = var.lb_probe

  loadbalancer_id = azurerm_lb.lb[each.value.lb_key].id
  name            = each.value.name
  port            = each.value.port
}

resource "azurerm_lb_rule" "lbrule" {
    for_each = var.lb_rule
    
  loadbalancer_id                = azurerm_lb.lb[each.value.lb_key].id
  name                           = each.value.name
  protocol                       = each.value.protocol
  frontend_port                  = each.value.frontend_port
  backend_port                   = each.value.backend_port
  frontend_ip_configuration_name = each.value.frontend_ip_configuration_name
  
  backend_address_pool_ids = [azurerm_lb_backend_address_pool.bpool
  [each.value.backend_pool_key].id
  ]
  probe_id = azurerm_lb_probe.lbprobe[each.value.probe_key].id
}


resource "azurerm_network_interface_backend_address_pool_association" "nicbpool" {
    for_each = var.backend_pool_association

  
  ip_configuration_name   = each.value.ip_configuration_name
  network_interface_id      = var.nic_ids[each.value.nic_key]
   backend_address_pool_id = azurerm_lb_backend_address_pool.bpool[each.value.backend_pool_key].id
}