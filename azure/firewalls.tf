resource "azurerm_application_security_group" "pks-master" {
  name                = "${var.env_name}-pks-master-app-sec-group"
  location            = var.location
  resource_group_name = azurerm_resource_group.platform.name
}

resource "azurerm_application_security_group" "pks-api" {
  name                = "${var.env_name}-pks-api-app-sec-group"
  location            = var.location
  resource_group_name = azurerm_resource_group.platform.name
}

resource "azurerm_network_security_group" "pks-master" {
  name                = "${var.env_name}-pks-master-sg"
  location            = var.location
  resource_group_name = azurerm_resource_group.platform.name

  security_rule {
    name                                       = "master"
    priority                                   = 100
    direction                                  = "Inbound"
    access                                     = "Allow"
    protocol                                   = "Tcp"
    source_port_range                          = "*"
    destination_port_range                     = "8443"
    source_address_prefix                      = "*"
    destination_application_security_group_ids = [azurerm_application_security_group.pks-master.id]
  }
}

resource "azurerm_network_security_group" "pks-api" {
  name                = "${var.env_name}-pks-api-sg"
  location            = var.location
  resource_group_name = azurerm_resource_group.platform.name

  security_rule {
    name                                       = "api"
    priority                                   = 100
    direction                                  = "Inbound"
    access                                     = "Allow"
    protocol                                   = "Tcp"
    source_port_range                          = "*"
    destination_port_ranges                    = ["9021", "8443"]
    source_address_prefix                      = "*"
    destination_application_security_group_ids = [azurerm_application_security_group.pks-api.id]
  }
}

resource "azurerm_network_security_group" "pks-internal" {
  name                = "${var.env_name}-pks-internal-sg"
  location            = var.location
  resource_group_name = azurerm_resource_group.platform.name

  security_rule {
    name                       = "internal"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefixes    = [local.pks_subnet_cidr, local.services_subnet_cidr]
    destination_address_prefix = "*"
  }
}

