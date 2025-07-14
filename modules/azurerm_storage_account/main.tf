resource "azurerm_storage_account" "test-stg" {
  name = var.Dev-STG
  resource_group_name = var.rg_name
  location = var.location
  account_replication_type = "LRS"
  account_tier = "Standard"
}
