variable "load_balancers" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    public_ip_id        = string
  }))
}
