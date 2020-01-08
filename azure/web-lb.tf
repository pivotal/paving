resource "azurerm_public_ip" "web-lb" {
  name                    = "web-lb-public-ip"
  location                = var.location
  resource_group_name     = azurerm_resource_group.platform.name
  allocation_method       = "Static"
  sku                     = "Standard"
  idle_timeout_in_minutes = 30
}

resource "azurerm_lb" "web" {
  name                = "${var.environment_name}-web-lb"
  location            = var.location
  resource_group_name = azurerm_resource_group.platform.name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "frontendip"
    public_ip_address_id = azurerm_public_ip.web-lb.id
  }
}

resource "azurerm_lb_backend_address_pool" "web" {
  name                = "${var.environment_name}-web-lb-backend-pool"
  resource_group_name = azurerm_resource_group.platform.name
  loadbalancer_id     = azurerm_lb.web.id
}

resource "azurerm_lb_probe" "web-https" {
  name                = "${var.environment_name}-web-lb-https-probe"
  resource_group_name = azurerm_resource_group.platform.name
  loadbalancer_id     = azurerm_lb.web.id
  protocol            = "TCP"
  port                = 443
}

resource "azurerm_lb_rule" "web-https" {
  name                = "${var.environment_name}-web-https-rule"
  resource_group_name = azurerm_resource_group.platform.name
  loadbalancer_id     = azurerm_lb.web.id

  frontend_ip_configuration_name = "frontendip"
  protocol                       = "TCP"
  frontend_port                  = 443
  backend_port                   = 443
  idle_timeout_in_minutes        = 30

  backend_address_pool_id = azurerm_lb_backend_address_pool.web.id
  probe_id                = azurerm_lb_probe.web-https.id
}

resource "azurerm_lb_probe" "web-http" {
  name                = "${var.environment_name}-web-http-probe"
  resource_group_name = azurerm_resource_group.platform.name
  loadbalancer_id     = azurerm_lb.web.id
  protocol            = "TCP"
  port                = 80
}

resource "azurerm_lb_rule" "web-http" {
  name                = "${var.environment_name}-web-http-rule"
  resource_group_name = azurerm_resource_group.platform.name
  loadbalancer_id     = azurerm_lb.web.id

  frontend_ip_configuration_name = "frontendip"
  protocol                       = "TCP"
  frontend_port                  = 80
  backend_port                   = 80
  idle_timeout_in_minutes        = 30

  backend_address_pool_id = azurerm_lb_backend_address_pool.web.id
  probe_id                = azurerm_lb_probe.web-http.id
}

resource "azurerm_lb_rule" "web-ntp" {
  name                = "${var.environment_name}-web-ntp-rule"
  resource_group_name = azurerm_resource_group.platform.name
  loadbalancer_id     = azurerm_lb.web.id

  frontend_ip_configuration_name = "frontendip"
  protocol                       = "UDP"
  frontend_port                  = "123"
  backend_port                   = "123"

  backend_address_pool_id = azurerm_lb_backend_address_pool.web.id
}
