module "my_rg" {
  source   = "./modules/azurerm_resource_group"
  rg_name  = var.rg_name
  location = var.location

}

module "mystg" {
  source     = "./modules/azurerm_storage_account"
  depends_on = [module.my_rg]
  Dev-STG    = var.Dev-STG
  rg_name    = var.rg_name
  location   = var.location

}


module "vnet" {
  source     = "./modules/azurerm_virtual_network"
  depends_on = [module.my_rg]
  rg_name    = var.rg_name
  location   = var.location
  prod_vnet  = var.prod_vnet
  new_subnet = var.new_subnet

}

# module "subnet" {
#     source = "./modules/azurerm_virtual_network"
#     depends_on = [ module.vnet ]
#     new_subnet = var.new_subnet
#     rg_name = var.rg_name
#     location = var.location
#     prod_vnet = var.prod_vnet

  
# }

module "my-vm" {
  source         = "./modules/azurerm_virtual_machine"
  depends_on     = [ module.my_rg, module.vnet ]
  new_vm         = var.new_vm
  rg_name        = var.rg_name
  location       = var.location
  subnet_id      = module.vnet.subnet_id
  admin_username = var.admin_username
  admin_password = azurerm_key_vault_secret.vm_password.value
}

module "yogi" {
  source         = "./modules/azurerm_virtual_machine"
  depends_on     = [ module.my_rg, module.vnet ]
  new_vm         = "Yogivm101"
  rg_name        = var.rg_name
  location       = var.location
  subnet_id      = module.vnet.subnet_id
  admin_username = var.admin_username
  admin_password = azurerm_key_vault_secret.vm_password.value
}

module "kv" {
    source = "./modules/Azurerm_kay_vault"
    rg_name = var.rg_name
    location = var.location
    new_vm = var.new_vm
    admin_username = var.admin_username
    admin_password = data.azurerm_key_vault_secret.vm_password.value
    secret_name = var.secret_name
    keyvault_name = var.keyvault_name
  
}





# module "my_rg1" {
#   source   = "./modules/azurerm_resource_group"
#   name  = "London_bridge1"
#   location = "East US"
# }

# module "my_rg2" {
#   source   = "./modules/azurerm_resource_group"
#   name  = "London_bridge2"
#   location = "East US"
# }