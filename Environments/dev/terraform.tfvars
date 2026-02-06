rgs = {
  rg1 = {
    name     = "rg-surendra-dev-app"
    location = "canada central"
    tags = {
      env   = "dev"
      owner = "surendra"
    }
  }
}

vnets = {
  vnet1 = {
    name                = "vnet-surendra-dev-app"
    location            = "canada central"
    resource_group_name = "rg-surendra-dev-app"
    address_space       = ["10.0.0.0/16"]
    tags = {
      env = "dev"
    }
  }
}

subnets = {

  appgw_subnet = {
    name                 = "AppGatewaySubnet"
    resource_group_name  = "rg-surendra-dev-app"
    virtual_network_name = "vnet-surendra-dev-app"
    prefixes             = ["10.0.1.0/24"]
  }

  frontend_subnet = {
    name                 = "frontend-subnet"
    resource_group_name  = "rg-surendra-dev-app"
    virtual_network_name = "vnet-surendra-dev-app"
    prefixes             = ["10.0.2.0/24"]
  }

  backend_subnet = {
    name                 = "backend-subnet"
    resource_group_name  = "rg-surendra-dev-app"
    virtual_network_name = "vnet-surendra-dev-app"
    prefixes             = ["10.0.3.0/24"]
  }

  bastion_subnet = {
    name                 = "AzureBastionSubnet"
    resource_group_name  = "rg-surendra-dev-app"
    virtual_network_name = "vnet-surendra-dev-app"
    prefixes             = ["10.0.4.0/24"]
  }

  privateendpoint_subnet = {
    name                 = "private-endpoint-subnet"
    resource_group_name  = "rg-surendra-dev-app"
    virtual_network_name = "vnet-surendra-dev-app"
    prefixes             = ["10.0.5.0/24"]
  }

}

nsgs = {

  frontend_nsg = {
    name                = "frontend-nsg"
    resource_group_name = "rg-surendra-dev-app"
    location            = "canada central"

    security_rules = [
      {
        name                       = "allow-http"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      },
      {
        name                       = "allow-https"
        priority                   = 110
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    ]
  }

  backend_nsg = {
    name                = "backend-nsg"
    resource_group_name = "rg-surendra-dev-app"
    location            = "canada central"

    security_rules = [
      {
        name                       = "allow-from-frontend"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefix      = "10.0.2.0/24"
        destination_address_prefix = "*"
      }
    ]
  }
}

nsg_associations = {
  frontend = {
    subnet_key = "frontend_subnet"
    nsg_key    = "frontend_nsg"
  }
  backend = {
    subnet_key = "backend_subnet"
    nsg_key    = "backend_nsg"
  }
}

public_ips = {
  appgw_pip = {
    name                = "pip-appgw-dev"
    resource_group_name = "rg-surendra-dev-app"
    location            = "canada central"
    allocation_method   = "Static"
    sku                 = "Standard"
  }

  lb_pip = {
    name                = "pip-lb-dev"
    resource_group_name = "rg-surendra-dev-app"
    location            = "canada central"
    allocation_method   = "Static"
    sku                 = "Standard"
  }
    bastion_pip = {
    name                = "pip-bastion-dev"
    resource_group_name = "rg-surendra-dev-app"
    location            = "canada central"
    allocation_method   = "Static"
    sku                 = "Standard"
  }

}

nics = {
  backend_nic = {
    subnet_key = "backend_subnet"
  }
}

load_balancers = {
  app_lb = {
    public_ip_key = "lb_pip"
  }
}

ssh_public_key_path = "C:/Users/suren/.ssh/id_rsa.pub"
vmss = {
  backend_vmss = {
    subnet_key        = "backend_subnet"
    lb_backend_key    = "app_lb"
    instances         = 2
  }
}

bastion = {
  main = {
    subnet_key   = "bastion_subnet"
    public_ip_key = "bastion_pip"
  }
}

app_gateways = {
  main = {
    subnet_key    = "appgw_subnet"
    public_ip_key = "appgw_pip"
    # Backend = VMSS instances (private IPs)
    backend_vmss_key = "backend_vmss"
  }
}

key_vaults = {
  main = {
    name = "kv-surendra-dev"
  }
}
