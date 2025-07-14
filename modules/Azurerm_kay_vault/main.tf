resource "azurerm_key_vault" "kv" {
  name = var.keyvault_name
  resource_group_name = var.rg_name
  location = var.location
  tenant_id = data_azurerm_clint_config.current.tenant_id
  sku_name = "standard"
  soft_delete_enabled         = true
  purge_protection_enabled    = false

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id  # current user's object ID

    secret_permissions = [
      "Get", "Set", "List",
    ]
  }
}

data "azurerm_client_config" "current" {}
  
resource "azurerm_key_vault_secret" "vm_password" {
  name         = var.secret_name
  value        = var.admin_password
  key_vault_id = azurerm_key_vault.kv.id
}

