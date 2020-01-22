resource "azurerm_public_ip" "ops-manager" {
  name                    = "${var.environment_name}-ops-manager-public-ip"
  location                = var.location
  resource_group_name     = azurerm_resource_group.platform.name
  allocation_method       = "Static"
  idle_timeout_in_minutes = 30

  tags = merge(
    var.tags,
    { name = "${var.environment_name}-ops-manager-public-ip" },
  )
}

resource "azurerm_network_security_group" "ops-manager" {
  name                = "${var.environment_name}-ops-manager-network-sg"
  location            = var.location
  resource_group_name = azurerm_resource_group.platform.name

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

  tags = merge(
    var.tags,
    { name = "${var.environment_name}-ops-manager-network-sg" },
  )
}

resource "tls_private_key" "ops_manager" {
  algorithm = "RSA"
  rsa_bits  = "4096"
}
