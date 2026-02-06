output "appgw_ids" {
  value = {
    for k, g in azurerm_application_gateway.this :
    k => g.id
  }
}
