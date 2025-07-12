resource "azurerm_virtual_network" "vnet" {
    name = var.prod_vnet
  resource_group_name = var.rg_name
  location = var.location
  address_space = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnet" {
    name = var.new_subnet
  resource_group_name = var.rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes = ["10.0.1.0/24"]
  
}

output "subnet_id" {
    value = azurerm_subnet.subnet.id
  
}