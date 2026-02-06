resource "azurerm_lb" "this" {
  for_each = var.load_balancers

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "frontend-ip"
    public_ip_address_id = each.value.public_ip_id
  }
}

resource "azurerm_lb_backend_address_pool" "backend_pool" {
  for_each = azurerm_lb.this

  name            = "backend-pool"
  loadbalancer_id = each.value.id
}

resource "azurerm_lb_probe" "http_probe" {
  for_each = azurerm_lb.this

  name            = "http-probe"
  loadbalancer_id = each.value.id
  protocol        = "Tcp"
  port            = 80
}

resource "azurerm_lb_rule" "http_rule" {
  for_each = azurerm_lb.this

  name                           = "http-rule"
  loadbalancer_id                = each.value.id
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "frontend-ip"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.backend_pool[each.key].id]
  probe_id                       = azurerm_lb_probe.http_probe[each.key].id
}
