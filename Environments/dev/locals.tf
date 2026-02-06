locals {
  nsg_associations_resolved = {
    for k, v in var.nsg_associations :
    k => {
      subnet_id = module.subnets.subnet_ids[v.subnet_key]
      nsg_id    = module.nsgs.nsg_ids[v.nsg_key]
    }
  }
}

locals {
  nics_resolved = {
    for k, v in var.nics :
    k => {
      name                  = "${k}-nic-dev"
      location              = "canada central"
      resource_group_name   = "rg-surendra-dev-app"
      subnet_id             = module.subnets.subnet_ids[v.subnet_key]
      private_ip_allocation = "Dynamic"
    }
  }
}

locals {
  load_balancers_resolved = {
    for k, v in var.load_balancers :
    k => {
      name                = "${k}-lb-dev"
      location            = "canada central"
      resource_group_name = "rg-surendra-dev-app"
      public_ip_id        = module.public_ips.public_ip_ids[v.public_ip_key]
    }
  }
}

# locals {
#   vmss_resolved = {
#     for k, v in var.vmss :
#     k => {
#       name                = "${k}-dev"
#       location            = "canada central"
#       resource_group_name = "rg-surendra-dev-app"

#       subnet_id       = module.subnets.subnet_ids[v.subnet_key]
#       backend_pool_id = module.load_balancer.backend_pool_ids[v.lb_backend_key]

#       sku        = "Standard_B2s"
#       instances = v.instances
#       admin_user = "surendra"
#       ssh_key    = file("~/.ssh/id_rsa.pub")
#     }
#   }
# }
locals {
  vmss_resolved = {
    for k, v in var.vmss :
    k => {
      name                = "${k}-dev"
      location            = "canada central"
      resource_group_name = "rg-surendra-dev-app"

      subnet_id       = module.subnets.subnet_ids[v.subnet_key]
      backend_pool_id = module.load_balancer.backend_pool_ids[v.lb_backend_key]

      sku         = "Standard_D2s_v3"
      instances   = v.instances
      admin_user  = "surendra"

      # 🔑 YAHAN SSH KEY AATI HAI
      ssh_key = file(var.ssh_public_key_path)
    }
  }
}


locals {
  bastion_resolved = {
    for k, v in var.bastion :
    k => {
      name                = "bastion-dev"
      location            = "canada central"
      resource_group_name = "rg-surendra-dev-app"

      subnet_id    = module.subnets.subnet_ids[v.subnet_key]
      public_ip_id = module.public_ips.public_ip_ids[v.public_ip_key]
    }
  }
}


locals {
  # Collect VMSS private IPs for AppGW backend
  vmss_private_ips = {
    for k, v in module.vmss.vmss_ids :
    k => [] # AppGW v2 typically integrates via IPs/endpoints; keep empty for now
  }

  app_gateways_resolved = {
    for k, v in var.app_gateways :
    k => {
      name                = "appgw-dev"
      location            = "canada central"
      resource_group_name = "rg-surendra-dev-app"

      subnet_id    = module.subnets.subnet_ids[v.subnet_key]
      public_ip_id = module.public_ips.public_ip_ids[v.public_ip_key]

      # If you later expose VMSS NIC IPs, populate this list
      backend_ip_ids = []
    }
  }
}


data "azurerm_client_config" "current" {}

locals {
  key_vaults_resolved = {
    for k, v in var.key_vaults :
    k => {
      name                = v.name
      location            = "canada central"
      resource_group_name = module.resource_group.rg_names["rg1"]

      tenant_id           = data.azurerm_client_config.current.tenant_id
      object_id           = data.azurerm_client_config.current.object_id
    }
  }
}

locals {
  # SQL ke liye
  sql_admin_password = data.azurerm_key_vault_secret.sql_admin_password.value

  # VMSS ke liye
  vmss_env_vars = {
    DB_PASSWORD = data.azurerm_key_vault_secret.vmss_db_password.value
  }
}
