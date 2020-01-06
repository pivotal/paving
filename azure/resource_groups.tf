resource "azurerm_resource_group" "platform" {
  name     = var.env_name
  location = var.location
}
