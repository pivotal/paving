resource "azurerm_lb" "mysql" {
  name                = "${var.environment_name}-mysql-lb"
  location            = var.location
  resource_group_name = azurerm_resource_group.platform.name
  sku                 = "Standard"

  frontend_ip_configuration {
    name      = "frontendip"
    subnet_id = azurerm_subnet.pas.id
  }
}

resource "azurerm_lb_backend_address_pool" "mysql" {
  name                = "${var.environment_name}-mysql-backend-pool"
  resource_group_name = azurerm_resource_group.platform.name
  loadbalancer_id     = azurerm_lb.mysql.id
}

resource "azurerm_lb_probe" "mysql" {
  name                = "${var.environment_name}-mysql-probe"
  resource_group_name = azurerm_resource_group.platform.name
  loadbalancer_id     = azurerm_lb.mysql.id
  protocol            = "TCP"
  port                = 1936
}

resource "azurerm_lb_rule" "mysql" {
  name                = "${var.environment_name}-mysql-rule"
  resource_group_name = azurerm_resource_group.platform.name
  loadbalancer_id     = azurerm_lb.mysql.id

  frontend_ip_configuration_name = "frontendip"
  protocol                       = "TCP"
  frontend_port                  = 3306
  backend_port                   = 3306

  backend_address_pool_id = azurerm_lb_backend_address_pool.mysql.id
  probe_id                = azurerm_lb_probe.mysql.id
}

resource "azurerm_lb_rule" "mysql-ntp" {
  name                = "${var.environment_name}-mysql-ntp-rule"
  resource_group_name = azurerm_resource_group.platform.name
  loadbalancer_id     = azurerm_lb.mysql.id

  frontend_ip_configuration_name = "frontendip"
  protocol                       = "UDP"
  frontend_port                  = "123"
  backend_port                   = "123"

  backend_address_pool_id = azurerm_lb_backend_address_pool.mysql.id
}

