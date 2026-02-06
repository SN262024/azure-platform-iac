variable "vmss" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    subnet_id           = string
    backend_pool_id     = string

    sku       = string
    instances = number
    admin_user = string
    ssh_key    = string
  }))
}
