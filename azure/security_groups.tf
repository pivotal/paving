resource "azurerm_network_security_group" "platform-vms" {
  name                = "${var.environment_name}-platform-vms-sg"
  location            = var.location
  resource_group_name = azurerm_resource_group.platform.name

  security_rule {
    name                       = "internal-anything"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "ssh"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = 22
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "bosh-agent"
    priority                   = 201
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = 6868
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "bosh-director"
    priority                   = 202
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = 25555
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "dns"
    priority                   = 203
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = 53
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "http"
    priority                   = 204
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = 80
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "https"
    priority                   = 205
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = 443
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "loggregator"
    priority                   = 206
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = 4443
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "diego-ssh"
    priority                   = 209
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = 2222
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "tcp"
    priority                   = 210
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "1024-1173"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }
}

resource "azurerm_application_security_group" "pks-master" {
  name                = "${var.environment_name}-pks-master-app-sec-group"
  location            = var.location
  resource_group_name = azurerm_resource_group.platform.name
}

resource "azurerm_application_security_group" "pks-api" {
  name                = "${var.environment_name}-pks-api-app-sec-group"
  location            = var.location
  resource_group_name = azurerm_resource_group.platform.name
}

resource "azurerm_network_security_group" "pks-master" {
  name                = "${var.environment_name}-pks-master-sg"
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
  name                = "${var.environment_name}-pks-api-sg"
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
  name                = "${var.environment_name}-pks-internal-sg"
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

