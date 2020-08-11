resource "azurerm_subnet" "pas" {
  name = "${var.environment_name}-pas-subnet"

  resource_group_name  = azurerm_resource_group.platform.name
  virtual_network_name = azurerm_virtual_network.platform.name
  address_prefix       = var.pas_subnet_cidr

  network_security_group_id = azurerm_network_security_group.platform-vms.id # Deprecated but required until AzureRM Provider 2.0
}

resource "azurerm_subnet_network_security_group_association" "pas" {
  subnet_id                 = azurerm_subnet.pas.id
  network_security_group_id = azurerm_network_security_group.platform-vms.id

  depends_on = [
    azurerm_subnet.pas,
    azurerm_network_security_group.platform-vms
  ]
}
