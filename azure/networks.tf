locals {
  management_subnet_cidr = "10.0.8.0/26"
  pas_subnet_cidr        = "10.0.0.0/22"
  services_subnet_cidr   = "10.0.4.0/22"
  pks_subnet_cidr        = "10.0.10.0/24"
}

resource "azurerm_virtual_network" "platform" {
  name                = "${var.env_name}-platform"
  depends_on          = [azurerm_resource_group.platform]
  resource_group_name = azurerm_resource_group.platform.name
  address_space       = ["10.0.0.0/16"]
  location            = var.location
}

resource "azurerm_subnet" "management" {
  name                 = "${var.env_name}-management-subnet"
  depends_on           = [azurerm_resource_group.platform]
  resource_group_name  = azurerm_resource_group.platform.name
  virtual_network_name = azurerm_virtual_network.platform.name
  address_prefix       = local.management_subnet_cidr
}

resource "azurerm_subnet_network_security_group_association" "ops-manager" {
  subnet_id                 = azurerm_subnet.management.id
  network_security_group_id = azurerm_network_security_group.ops-manager.id
}

resource "azurerm_subnet" "pks" {
  name                 = "${var.env_name}-pks-subnet"
  resource_group_name  = azurerm_resource_group.platform.name
  virtual_network_name = azurerm_virtual_network.platform.name
  address_prefix       = local.pks_subnet_cidr
}

resource "azurerm_subnet" "pas" {
  name = "${var.env_name}-pas-subnet"

  resource_group_name  = azurerm_resource_group.platform.name
  virtual_network_name = azurerm_virtual_network.platform.name
  address_prefix       = local.pas_subnet_cidr
}

resource "azurerm_subnet_network_security_group_association" "pas" {
  subnet_id                 = azurerm_subnet.pas.id
  network_security_group_id = azurerm_network_security_group.platform-vms.id
}

resource "azurerm_subnet" "services" {
  name = "${var.env_name}-services-subnet"

  resource_group_name  = azurerm_resource_group.platform.name
  virtual_network_name = azurerm_virtual_network.platform.name
  address_prefix       = local.services_subnet_cidr
}

resource "azurerm_subnet_network_security_group_association" "services" {
  subnet_id                 = azurerm_subnet.services.id
  network_security_group_id = azurerm_network_security_group.platform-vms.id
}

