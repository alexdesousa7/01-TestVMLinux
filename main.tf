provider "azurerm" {
  version = "=1.35.0"
}

# Create a resource group
resource "azurerm_resource_group" "Test01" {
  name     = "first-steps-TFLinux"
  location = var.location
}
