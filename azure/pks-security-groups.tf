resource "azurerm_network_security_group" "pks-master" {
  name                = "${var.environment_name}-pks-master-network-sg"
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

  tags = merge(
  var.tags,
  { name = "${var.environment_name}-pks-master-network-sg" },
  )
}

resource "azurerm_network_security_group" "pks-api" {
  name                = "${var.environment_name}-pks-api-network-sg"
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

  tags = merge(
  var.tags,
  { name = "${var.environment_name}-pks-api-network-sg" },
  )
}

resource "azurerm_network_security_group" "pks-internal" {
  name                = "${var.environment_name}-pks-internal-network-sg"
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
    source_address_prefixes    = [var.pks_subnet_cidr, var.services_subnet_cidr]
    destination_address_prefix = "*"
  }

  tags = merge(
  var.tags,
  { name = "${var.environment_name}-pks-internal-network-sg" },
  )
}

resource "azurerm_application_security_group" "pks-master" {
  name                = "${var.environment_name}-pks-master-app-sg"
  location            = var.location
  resource_group_name = azurerm_resource_group.platform.name

  tags = merge(
  var.tags,
  { name = "${var.environment_name}-pks-master-app-sg" },
  )
}

resource "azurerm_application_security_group" "pks-api" {
  name                = "${var.environment_name}-pks-api-app-sg"
  location            = var.location
  resource_group_name = azurerm_resource_group.platform.name

  tags = merge(
  var.tags,
  { name = "${var.environment_name}-pks-api-app-sg" },
  )
}
