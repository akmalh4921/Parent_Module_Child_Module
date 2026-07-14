rgs = {
  rg1 = {
    name     = "rg-dev-04"
    location = "central india"
  }
}

strg = {
  strg1 = {
    name                     = "strgaccdev04"
    location                 = "central india"
    resource_group_name      = "rg-dev-04"
    account_tier             = "Standard"
    account_replication_type = "GRS"

  }
}

ctnr = {
  ctnr1 = {

  name = "ctnr-dev-04"
  storage_account_key =  "strg1"
  container_access_type = "private"
}
}

vnets = {
  vnet1 = {
    name                = "vnet-dev-04"
    location            = "central india"
    resource_group_name = "rg-dev-04"
    address_space       = ["10.0.0.0/16"]
  }

  vnet2 = {
    name                = "vnet-dev-05"
    location            = "central india"
    resource_group_name = "rg-dev-04"
    address_space       = ["20.0.0.0/16"]
  }

}

subnets = {
  subnet1 = {
    name                 = "subnet4"
    resource_group_name  = "rg-dev-04"
    virtual_network_name = "vnet-dev-04"
    address_prefixes     = ["10.0.1.0/24"]
  }

  subnet2 = {
    name                 = "subnet5"
    resource_group_name  = "rg-dev-04"
    virtual_network_name = "vnet-dev-05"
    address_prefixes     = ["20.0.1.0/24"]
  }

  subnet3 = {
    name                 = "AzureBastionSubnet"
    resource_group_name  = "rg-dev-04"
    virtual_network_name = "vnet-dev-04"
    address_prefixes     = ["10.0.2.0/24"]
  }
}

public_ips = {
  pip1 = {
    name                = "BastionIp"
    resource_group_name = "rg-dev-04"
    location            = "central india"
    allocation_method   = "Static"
    sku                 = "Standard"
  }
  pip2 = {
    name                = "LoadBalancerIp"
    resource_group_name = "rg-dev-04"
    location            = "central india"
    allocation_method   = "Static"
    sku                 = "Standard"
  }
}

nics = {
  nic1 = {
    name                = "NetworkInterfaceCard1"
    location            = "central india"
    resource_group_name = "rg-dev-04"
    subnet_key          = "subnet1"

    ip_configuration = {
      name                          = "internal"
      private_ip_address_allocation = "Dynamic"
    }
  }

  nic2 = {
    name                = "NetworkInterfaceCard2"
    location            = "central india"
    resource_group_name = "rg-dev-04"
    subnet_key          = "subnet2"

    ip_configuration = {
      name                          = "internal"
      private_ip_address_allocation = "Dynamic"
    }
  }

}



nsgs = {
  nsg1 = {
    name                = "NetworkSecurityGroup1"
    location            = "central india"
    resource_group_name = "rg-dev-04"

    security_rule = {
      name                       = "SSH_HTTP"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_ranges    = ["22", "80"]
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  }

  nsg2 = {
    name                = "NetworkSecurityGroup2"
    location            = "central india"
    resource_group_name = "rg-dev-04"

    security_rule = {
      name                       = "SSH_HTTP"
      priority                   = 110
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_ranges    = ["22", "80"]
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  }

}

nic_nsg_association = {
  asso1 = {
    nic_key = "nic1"
    nsg_key = "nsg1"
  }
  asso2 = {
    nic_key = "nic2"
    nsg_key = "nsg2"
  }
}


peering = {
  peering1 = {
    name                         = "peer-vnet-dev-04topeer-vnet-dev-05"
    resource_group_name          = "rg-dev-04"
    virtual_network_name         = "vnet-dev-04"
    vnet_key                     = "vnet2"
    allow_virtual_network_access = true

  }

  peering2 = {
    name                         = "peer-vnet-dev-05topeer-vnet-dev-04"
    resource_group_name          = "rg-dev-04"
    virtual_network_name         = "vnet-dev-05"
    vnet_key                     = "vnet1"
    allow_virtual_network_access = true

  }
}

bsn = {
  bsn1 = {
    name                = "AzureBastion"
    location            = "central india"
    resource_group_name = "rg-dev-04"
    subnet_key          = "subnet3"
    pip_key             = "pip1"

    ip_configuration = {
      name = "BastionIp"

    }
  }
}

linux_vms = {
  vm1 = {
    name                            = "Linux-VM-01"
    resource_group_name             = "rg-dev-04"
    location                        = "central india"
    size                            = "Standard_D2s_v3"
    admin_username                  = "devopsadmin"
    admin_password                  = "Devops@12345"
    disable_password_authentication = false
    nic_key                         = "nic1"

    os_disk = {
      caching              = "ReadWrite"
      storage_account_type = "Standard_LRS"
    }

    source_image_reference = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-jammy"
      sku       = "22_04-lts"
      version   = "latest"
    }
  }

  vm2 = {
    name                            = "Linux-VM-02"
    resource_group_name             = "rg-dev-04"
    location                        = "central india"
    size                            = "Standard_D2s_v3"
    admin_username                  = "devopsadmin"
    admin_password                  = "Devops@12345"
    disable_password_authentication = false
    nic_key                         = "nic2"



    os_disk = {
      caching              = "ReadWrite"
      storage_account_type = "Standard_LRS"
    }

    source_image_reference = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-jammy"
      sku       = "22_04-lts"
      version   = "latest"
    }
  }
}

load_balancer = {
  lb1 = {
    name                = "AzureLoadBalancer"
    location            = "central india"
    resource_group_name = "rg-dev-04"
    sku                 = "Standard"


    frontend_ip_configuration = {
      name    = "LoadBalancerIp"
      pip_key = "pip2"

    }
  }
}

backend_pool = {
  bpool1 = {
    lb_key = "lb1"
    name   = "BackEndAddressPool"
  }
}

lb_probe = {
  lb_probe1 = {
    lb_key = "lb1"
    name   = "ssh-running-probe"
    port   = 80
  }
}


lb_rule = {
  lb_rule1 = {
    lb_key                         = "lb1"
    name                           = "LBRule"
    protocol                       = "Tcp"
    frontend_port                  = 80
    backend_port                   = 80
    frontend_ip_configuration_name = "LoadBalancerIp"
    probe_key                      = "lb_probe1"
    backend_pool_key               = "bpool1"
  }
}


backend_pool_association = {
  backend_pool_association1 = {
    nic_key               = "nic1"
    ip_configuration_name = "internal"
    backend_pool_key      = "bpool1"
  }
  backend_pool_association2 = {
    nic_key               = "nic2"
    ip_configuration_name = "internal"
    backend_pool_key      = "bpool1"
  }
}