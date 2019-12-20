resource "azurerm_resource_group" "pivotal_platform_rg" {
  name     = var.environment_name
  location = var.location
}