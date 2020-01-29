resource "azurerm_availability_set" "pks_as" {
  name                = "${var.environment_name}-pks-as"
  location            = var.location
  resource_group_name = azurerm_resource_group.platform.name

  tags = var.tags
}
