resource "azurerm_subnet" "management" {
  name = "${var.environment_name}-management-subnet"

  resource_group_name  = azurerm_resource_group.platform.name
  virtual_network_name = azurerm_virtual_network.platform.name
  address_prefix       = var.management_subnet_cidr

  network_security_group_id = azurerm_network_security_group.ops-manager.id # Deprecated but required until AzureRM Provider 2.0
}

resource "azurerm_subnet_network_security_group_association" "ops-manager" {
  subnet_id                 = azurerm_subnet.management.id
  network_security_group_id = azurerm_network_security_group.ops-manager.id

  depends_on = [
    azurerm_subnet.management,
    azurerm_network_security_group.ops-manager
  ]
}

resource "azurerm_subnet" "services" {
  name = "${var.environment_name}-services-subnet"

  resource_group_name  = azurerm_resource_group.platform.name
  virtual_network_name = azurerm_virtual_network.platform.name
  address_prefix       = var.services_subnet_cidr

  network_security_group_id = azurerm_network_security_group.platform-vms.id # Deprecated but required until AzureRM Provider 2.0
}

resource "azurerm_subnet_network_security_group_association" "services" {
  subnet_id                 = azurerm_subnet.services.id
  network_security_group_id = azurerm_network_security_group.platform-vms.id

  depends_on = [
    azurerm_subnet.services,
    azurerm_network_security_group.platform-vms
  ]
}
