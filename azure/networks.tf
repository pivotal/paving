resource "azurerm_virtual_network" "platform" {
  name                = "${var.environment_name}-platform"
  depends_on          = [azurerm_resource_group.platform]
  resource_group_name = azurerm_resource_group.platform.name
  address_space       = ["10.0.0.0/16"]
  location            = var.location

  tags = merge(
    var.tags,
    { "Name" = "${var.environment_name}-platform" },
  )
}

