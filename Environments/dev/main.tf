module "resource_group" {
  source = "../../modules/azurerm_resource_group"
  rgs    = var.rgs
}
module "virtual_network" {
  depends_on = [ module.resource_group ]
  source = "../../modules/azurerm_virtual_network"
  vnets  = var.vnets
}

module "subnets" {
  depends_on = [module.resource_group, module.virtual_network ]
  source  = "../../modules/azurerm_subnet"
  subnets = var.subnets
}

module "nsgs" {
  depends_on = [module.resource_group ]
  source = "../../modules/azurerm_nsg"
  nsgs   = var.nsgs
  
}

module "nsg_associations" {
  depends_on = [module.subnets, module.nsgs]
  source     = "../../modules/azurerm_nsg_connection"

  nsg_associations = local.nsg_associations_resolved
}

module "public_ips" {
  depends_on = [module.resource_group]
  source     = "../../modules/azurerm_public_ip"
  public_ips = var.public_ips
}

module "nic" {
  # depends_on = [module.nsg_associations]

  source = "../../modules/azurerm_nic"
  nics   = local.nics_resolved
}

module "load_balancer" {
  source          = "../../modules/azurerm_lb"
  load_balancers  = local.load_balancers_resolved
}

module "vmss" {
  source = "../../modules/azurerm_vmss"
  vmss   = local.vmss_resolved
}

module "bastion" {
  source = "../../modules/azurerm_azure_bastion"
  bastion = local.bastion_resolved
}

module "app_gateway" {
  source        = "../../modules/azurerm_appgtw"
  app_gateways  = local.app_gateways_resolved
}

module "key_vaults" {
  source      = "../../modules/azurerm_key_vault"
  key_vaults = local.key_vaults_resolved

  
}