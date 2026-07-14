output "lb_ids" {
  value = {
    for key, lb in azurerm_lb.lb : key => lb.id
  }
}

output "backend_pool_id" {
  value = {
    for key, bpool in azurerm_lb_backend_address_pool.bpool : key => bpool.id
  }
}