resource "azurerm_public_ip" "diego-ssh-lb" {
  name                = "${var.env_name}-diego-ssh-lb-public-ip"
  location            = var.location
  resource_group_name = azurerm_resource_group.platform.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_lb" "diego-ssh" {
  name                = "${var.env_name}-diego-ssh-lb"
  location            = var.location
  resource_group_name = azurerm_resource_group.platform.name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "frontendip"
    public_ip_address_id = azurerm_public_ip.diego-ssh-lb.id
  }
}

resource "azurerm_lb_backend_address_pool" "diego-ssh" {
  name                = "${var.env_name}-diego-ssh-backend-pool"
  resource_group_name = azurerm_resource_group.platform.name
  loadbalancer_id     = azurerm_lb.diego-ssh.id
}

resource "azurerm_lb_probe" "diego-ssh" {
  name                = "${var.env_name}-diego-ssh-probe"
  resource_group_name = azurerm_resource_group.platform.name
  loadbalancer_id     = azurerm_lb.diego-ssh.id
  protocol            = "TCP"
  port                = 2222
}

resource "azurerm_lb_rule" "diego-ssh" {
  name                = "${var.env_name}-diego-ssh-rule"
  resource_group_name = azurerm_resource_group.platform.name
  loadbalancer_id     = azurerm_lb.diego-ssh.id

  frontend_ip_configuration_name = "frontendip"
  protocol                       = "TCP"
  frontend_port                  = 2222
  backend_port                   = 2222

  backend_address_pool_id = azurerm_lb_backend_address_pool.diego-ssh.id
  probe_id                = azurerm_lb_probe.diego-ssh.id
}

resource "azurerm_lb_rule" "diego-ssh-ntp" {
  name                = "${var.env_name}-diego-ssh-ntp-rule"
  resource_group_name = azurerm_resource_group.platform.name
  loadbalancer_id     = azurerm_lb.diego-ssh.id

  frontend_ip_configuration_name = "frontendip"
  protocol                       = "UDP"
  frontend_port                  = "123"
  backend_port                   = "123"

  backend_address_pool_id = azurerm_lb_backend_address_pool.diego-ssh.id
}

