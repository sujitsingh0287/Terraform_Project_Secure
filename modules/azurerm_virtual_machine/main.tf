resource "azurerm_network_interface" "nic" {
    name = "${var.new_vm}-nic"
  resource_group_name = var.rg_name
  location = var.location

  ip_configuration {
    name = "${var.new_vm}-ipconfig"
    subnet_id = var.subnet_id
    private_ip_address_allocation = "Dynamic"
 }

}

resource "azurerm_windows_virtual_machine" "vm" {
  name = var.new_vm
  resource_group_name = var.rg_name
  location = var.location
  size = "Standard_B1s"
  admin_username = var.admin_username
  admin_password = var.admin_password
  network_interface_ids = [azurerm_network_interface.nic.id]

  os_disk  {
    caching = "ReadWrite"
    storage_account_type = "Standard_LRS" 
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer = "WindowsServer"
    sku = "2019-Datacenter"
    version = "latest"
  }
}
