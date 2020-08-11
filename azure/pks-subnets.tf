resource "azurerm_subnet" "pks" {
  name = "${var.environment_name}-pks-subnet"

  resource_group_name  = azurerm_resource_group.platform.name
  virtual_network_name = azurerm_virtual_network.platform.name
  address_prefix       = var.pks_subnet_cidr

  network_security_group_id = azurerm_network_security_group.pks-api.id # Deprecated but required until AzureRM Provider 2.0
}

resource "azurerm_subnet_network_security_group_association" "pks" {
  subnet_id                 = azurerm_subnet.pks.id
  network_security_group_id = azurerm_network_security_group.pks-api.id

  depends_on = [
    azurerm_subnet.pks,
    azurerm_network_security_group.platform-vms
  ]
}
