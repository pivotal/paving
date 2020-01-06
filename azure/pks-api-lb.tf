resource "azurerm_public_ip" "pks-lb" {
  name                = "${var.env_name}-pks-lb-ip"
  location            = var.location
  resource_group_name = azurerm_resource_group.platform.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_lb" "pks-lb" {
  name                = "${var.env_name}-pks-lb"
  location            = var.location
  sku                 = "Standard"
  resource_group_name = azurerm_resource_group.platform.name

  frontend_ip_configuration {
    name                 = azurerm_public_ip.pks-lb.name
    public_ip_address_id = azurerm_public_ip.pks-lb.id
  }
}

resource "azurerm_lb_backend_address_pool" "pks-lb" {
  name                = "${var.env_name}-pks-backend-pool"
  resource_group_name = azurerm_resource_group.platform.name
  loadbalancer_id     = azurerm_lb.pks-lb.id
}

resource "azurerm_lb_probe" "pks-lb-uaa" {
  name                = "${var.env_name}-pks-lb-uaa-health-probe"
  resource_group_name = azurerm_resource_group.platform.name
  loadbalancer_id     = azurerm_lb.pks-lb.id
  protocol            = "Tcp"
  interval_in_seconds = 5
  number_of_probes    = 2
  port                = 8443
}

resource "azurerm_lb_rule" "pks-lb-uaa" {
  name                           = "${var.env_name}-pks-lb-uaa-rule"
  resource_group_name            = azurerm_resource_group.platform.name
  loadbalancer_id                = azurerm_lb.pks-lb.id
  protocol                       = "Tcp"
  frontend_port                  = 8443
  backend_port                   = 8443
  frontend_ip_configuration_name = azurerm_public_ip.pks-lb.name
  probe_id                       = azurerm_lb_probe.pks-lb-uaa.id
  backend_address_pool_id        = azurerm_lb_backend_address_pool.pks-lb.id
}

resource "azurerm_lb_probe" "pks-lb-api" {
  name                = "${var.env_name}-pks-lb-api-health-probe"
  resource_group_name = azurerm_resource_group.platform.name
  loadbalancer_id     = azurerm_lb.pks-lb.id
  protocol            = "Tcp"
  interval_in_seconds = 5
  number_of_probes    = 2
  port                = 9021
}

resource "azurerm_lb_rule" "pks-lb-api-rule" {
  name                           = "${var.env_name}-pks-lb-api-rule"
  resource_group_name            = azurerm_resource_group.platform.name
  loadbalancer_id                = azurerm_lb.pks-lb.id
  protocol                       = "Tcp"
  frontend_port                  = 9021
  backend_port                   = 9021
  frontend_ip_configuration_name = azurerm_public_ip.pks-lb.name
  probe_id                       = azurerm_lb_probe.pks-lb-api.id
  backend_address_pool_id        = azurerm_lb_backend_address_pool.pks-lb.id
}

