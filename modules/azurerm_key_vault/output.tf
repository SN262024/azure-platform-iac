output "key_vault_ids" {
  value = {
    for k, kv in azurerm_key_vault.this :
    k => kv.id
  }
}

output "key_vault_names" {
  value = {
    for k, kv in azurerm_key_vault.this :
    k => kv.name
  }
}
