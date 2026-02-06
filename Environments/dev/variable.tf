variable "rgs" {
  type = map(object({
    name     = string
    location = string
    tags     = optional(map(string), {})
  }))
}

variable "vnets" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    address_space       = list(string)
    tags                = optional(map(string), {})
  }))
}

variable "subnets" {
  type = map(object({
    name                 = string
    resource_group_name  = string
    virtual_network_name = string
    prefixes             = list(string)
  }))
}

variable "nsgs" {
  type = map(object({
    name                = string
    resource_group_name = string
    location            = string

    security_rules = list(object({
      name                       = string
      priority                   = number
      direction                  = string
      access                     = string
      protocol                   = string
      source_port_range          = string
      destination_port_range     = string
      source_address_prefix      = string
      destination_address_prefix = string
    }))
  }))
}

variable "nsg_associations" {
  type = map(object({
    subnet_key = string
    nsg_key    = string
  }))
}

variable "public_ips" {
  type = map(object({
    name                = string
    resource_group_name = string
    location            = string
    allocation_method   = string
    sku                 = string
  }))
}

variable "nics" {
  type = map(object({
    subnet_key = string
  }))
}

variable "load_balancers" {
  type = map(object({
    public_ip_key = string
  }))
}

variable "ssh_public_key_path" {
  description = "Path of SSH public key for Linux VMSS"
  type        = string
}

variable "vmss" {
  type = map(object({
    subnet_key     = string
    lb_backend_key = string
    instances      = number
  }))
}

variable "bastion" {
  type = map(object({
    subnet_key    = string
    public_ip_key = string
  }))
}

variable "app_gateways" {
  type = map(object({
    subnet_key        = string
    public_ip_key     = string
    backend_vmss_key  = string
  }))
}

variable "key_vaults" {
  type = map(object({
    name = string
  }))
}
