# Test01 instance
resource "azurerm_virtual_machine" "Test01-instance" {
  name                  = "${var.prefix}-vm01"
  location              = var.location
  resource_group_name   = azurerm_resource_group.Test01.name
  network_interface_ids = [azurerm_network_interface.Test01-instance.id]
  vm_size               = "Standard_A1_v2"

  # this is a demo instance, so we can delete all data on termination
  delete_os_disk_on_termination = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
  storage_os_disk {
    name              = "${var.prefix}-OSdisk01"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "AZVMLinux01"
    admin_username = "linuxusr"
    #admin_password = "..."
  }
  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      key_data = file("mykey.pub")
      path     = "/home/linuxusr/.ssh/authorized_keys"
    }
  }
}

resource "azurerm_network_interface" "Test01-instance" {
  name                      = "${var.prefix}-instance1"
  location                  = var.location
  resource_group_name       = azurerm_resource_group.Test01.name
  network_security_group_id = azurerm_network_security_group.allow-ssh.id

  ip_configuration {
    name                          = "instance1"
    subnet_id                     = azurerm_subnet.Test01-internal-1.id
    private_ip_address_allocation = "Dynamic"
#    public_ip_address_id          = azurerm_public_ip.Test01-instance.id
  }
}

#resource "azurerm_public_ip" "Test01-instance" {
#    name                         = "${var.prefix}-public-ip"
#    location                     = var.location
#    resource_group_name          = azurerm_resource_group.Test01.name
#    allocation_method            = "Dynamic"
#}
