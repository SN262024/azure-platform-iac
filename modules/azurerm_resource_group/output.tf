output "rg_names" {
  value = {
    for k, rg in azurerm_resource_group.this :
    k => rg.name
  }
}


output "rg_locations" {
  value = { for k, v in azurerm_resource_group.this : k => v.location }
}
