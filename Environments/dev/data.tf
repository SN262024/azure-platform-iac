# SQL admin password
data "azurerm_key_vault_secret" "sql_admin_password" {
  name         = "sql-admin-password"
  key_vault_id = module.key_vault.key_vault_ids["main"]
}

# VMSS secret
data "azurerm_key_vault_secret" "vmss_db_password" {
  name         = "vmss-db-password"
  key_vault_id = module.key_vault.key_vault_ids["main"]
}
