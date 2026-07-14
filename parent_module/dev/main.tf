module "resource_group" {
  source = "../../child_module/azurerm_resource_group"

  rgs = var.rgs
}

module "storage_account" {
  source = "../../child_module/azurerm_storage_account"
  strg   = var.strg

  depends_on = [module.resource_group]

}

module "container" {
  source              = "../../child_module/azurerm_storage_container"
  ctnr                = var.ctnr
  storage_account_ids = module.storage_account.storage_account_ids

  depends_on = [module.storage_account]

}

module "virtual_network" {
  source = "../../child_module/azurerm_virtual_network"

  vnets = var.vnets

  depends_on = [module.resource_group]
}

module "subnet" {
  source = "../../child_module/azurerm_subnet"

  subnets = var.subnets

  depends_on = [module.virtual_network]
}

module "pip" {
  source = "../../child_module/azurerm_public_ip"
  pips   = var.public_ips

  depends_on = [module.resource_group]
}

module "nics" {
  source = "../../child_module/azurerm_network_interface"
  nics   = var.nics

  subnet_ids = module.subnet.subnet_ids

  depends_on = [module.subnet]
}

module "nsgs" {
  source     = "../../child_module/azurerm_network_security_group"
  nsgs       = var.nsgs
  depends_on = [module.resource_group]
}

module "NicNsgAssociation" {
  source              = "../../child_module/azurerm_network_interface_security_group_association"
  nic_nsg_association = var.nic_nsg_association

  nic_ids    = module.nics.nic_ids
  nsg_ids    = module.nsgs.nsg_ids
  depends_on = [module.nics, module.nsgs, module.resource_group]
}

module "VnetPeering" {
  source  = "../../child_module/azurerm_virtual_network_peering"
  peering = var.peering

  vnet_ids = module.virtual_network.vnet_ids

  depends_on = [module.virtual_network]
}

module "Bastion" {
  source = "../../child_module/azurerm_bastion_host"
  bsn    = var.bsn

  subnet_ids = module.subnet.subnet_ids
  pip_ids    = module.pip.pip_ids

  depends_on = [module.resource_group, module.pip, module.subnet]

}

module "linuxVms" {
  source    = "../../child_module/azurerm_linux_virtual_machine"
  linux_vms = var.linux_vms

  nic_ids    = module.nics.nic_ids
  depends_on = [module.resource_group, module.nics]

}

module "LoadBalancer" {
  source = "../../child_module/azurerm_lb"

  load_balancer            = var.load_balancer
  backend_pool             = var.backend_pool
  lb_rule                  = var.lb_rule
  lb_probe                 = var.lb_probe
  backend_pool_association = var.backend_pool_association

  pip_ids = module.pip.pip_ids
  nic_ids = module.nics.nic_ids

  depends_on = [
    module.pip,
    module.nics
  ]
}
