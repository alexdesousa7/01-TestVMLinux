
resource "azurerm_virtual_network" "Test01" {
  name                = "${var.prefix}-network"
  location            = var.location
  resource_group_name = azurerm_resource_group.Test01.name
  address_space       = ["192.168.1.0/24"]
}

resource "azurerm_subnet" "Test01-internal-1" {
  name                 = "${var.prefix}-internal-1"
  resource_group_name  = azurerm_resource_group.Test01.name
  virtual_network_name = azurerm_virtual_network.Test01.name
  address_prefix       = "192.168.1.0/26"
}

resource "azurerm_network_security_group" "allow-ssh" {
    name                = "${var.prefix}-allow-ssh"
    location            = var.location
    resource_group_name = azurerm_resource_group.Test01.name

    security_rule {
        name                       = "SSH"
        priority                   = 310
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = var.ssh-source-address
        destination_address_prefix = "*"
    }
}
