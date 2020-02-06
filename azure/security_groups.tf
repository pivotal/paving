resource "azurerm_network_security_group" "platform-vms" {
  name                = "${var.environment_name}-platform-vms-sg"
  location            = var.location
  resource_group_name = azurerm_resource_group.platform.name

  security_rule {
    name                       = "internal-anything"
    description                = "Allow internal traffic within the network"
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
    description                = "Allow SSH to VMs in the network"
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
    description                = "Access to the bosh agent VM"
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
    description                = "Allow access to the bosh director"
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
    description                = "Allow inbound DNS resolution"
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
    description                = "Allow inbound HTTP traffic from Internet"
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
    description                = "Allow inbound HTTPS traffic from Internet"
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
    description                = "Allow inbound loggregator traffic from Internet"
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
    description                = "Allow inbound diego ssh (different port) traffic from Internet"
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
    description                = "Please explain this port range"
    priority                   = 210
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "1024-1173"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }

  tags = merge(
    var.tags,
    { name = "${var.environment_name}-platform-vms-network-sg" },
  )
}

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
