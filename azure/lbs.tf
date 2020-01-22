# Web
resource "azurerm_public_ip" "web-lb" {
  name                    = "web-lb-public-ip"
  location                = var.location
  resource_group_name     = azurerm_resource_group.platform.name
  allocation_method       = "Static"
  sku                     = "Standard"
  idle_timeout_in_minutes = 30

  tags = merge(
    var.tags,
    { name = "${var.environment_name}-web-lb-public-ip" },
  )
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

  tags = merge(
    var.tags,
    { name = "${var.environment_name}-web-lb" },
  )
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

# TCP
resource "azurerm_public_ip" "tcp-lb" {
  name                = "${var.environment_name}-tcp-lb-public-ip"
  location            = var.location
  resource_group_name = azurerm_resource_group.platform.name
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = merge(
    var.tags,
    { name = "${var.environment_name}-tcp-lb-public-ip" },
  )
}

resource "azurerm_lb" "tcp" {
  name                = "${var.environment_name}-tcp-lb"
  location            = var.location
  resource_group_name = azurerm_resource_group.platform.name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "frontendip"
    public_ip_address_id = azurerm_public_ip.tcp-lb.id
  }

  tags = merge(
    var.tags,
    { name = "${var.environment_name}-tcp-lb" },
  )
}

resource "azurerm_lb_backend_address_pool" "tcp" {
  name                = "${var.environment_name}-tcp-backend-pool"
  resource_group_name = azurerm_resource_group.platform.name
  loadbalancer_id     = azurerm_lb.tcp.id
}

resource "azurerm_lb_probe" "tcp" {
  name                = "${var.environment_name}-tcp-probe"
  resource_group_name = azurerm_resource_group.platform.name
  loadbalancer_id     = azurerm_lb.tcp.id
  protocol            = "TCP"
  port                = 80
}

resource "azurerm_lb_rule" "tcp-rule" {
  count               = 5
  name                = "${var.environment_name}-tcp-rule-${count.index + 1024}"
  resource_group_name = azurerm_resource_group.platform.name
  loadbalancer_id     = azurerm_lb.tcp.id

  frontend_ip_configuration_name = "frontendip"
  protocol                       = "TCP"
  frontend_port                  = count.index + 1024
  backend_port                   = count.index + 1024

  backend_address_pool_id = azurerm_lb_backend_address_pool.tcp.id
  probe_id                = azurerm_lb_probe.tcp.id
}

resource "azurerm_lb_rule" "tcp-ntp" {
  name                = "${var.environment_name}-tcp-ntp-rule"
  resource_group_name = azurerm_resource_group.platform.name
  loadbalancer_id     = azurerm_lb.tcp.id

  frontend_ip_configuration_name = "frontendip"
  protocol                       = "UDP"
  frontend_port                  = "123"
  backend_port                   = "123"

  backend_address_pool_id = azurerm_lb_backend_address_pool.tcp.id
}

# MySQL
resource "azurerm_lb" "mysql" {
  name                = "${var.environment_name}-mysql-lb"
  location            = var.location
  resource_group_name = azurerm_resource_group.platform.name
  sku                 = "Standard"

  frontend_ip_configuration {
    name      = "frontendip"
    subnet_id = azurerm_subnet.pas.id
  }

  tags = merge(
    var.tags,
    { name = "${var.environment_name}-mysql-lb" },
  )
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

# SSH
resource "azurerm_public_ip" "diego-ssh-lb" {
  name                = "${var.environment_name}-diego-ssh-lb-public-ip"
  location            = var.location
  resource_group_name = azurerm_resource_group.platform.name
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = merge(
    var.tags,
    { name = "${var.environment_name}-diego-ssh-lb-public-ip" },
  )
}

resource "azurerm_lb" "diego-ssh" {
  name                = "${var.environment_name}-diego-ssh-lb"
  location            = var.location
  resource_group_name = azurerm_resource_group.platform.name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "frontendip"
    public_ip_address_id = azurerm_public_ip.diego-ssh-lb.id
  }

  tags = merge(
    var.tags,
    { name = "${var.environment_name}-diego-ssh-lb" },
  )
}

resource "azurerm_lb_backend_address_pool" "diego-ssh" {
  name                = "${var.environment_name}-diego-ssh-backend-pool"
  resource_group_name = azurerm_resource_group.platform.name
  loadbalancer_id     = azurerm_lb.diego-ssh.id
}

resource "azurerm_lb_probe" "diego-ssh" {
  name                = "${var.environment_name}-diego-ssh-probe"
  resource_group_name = azurerm_resource_group.platform.name
  loadbalancer_id     = azurerm_lb.diego-ssh.id
  protocol            = "TCP"
  port                = 2222
}

resource "azurerm_lb_rule" "diego-ssh" {
  name                = "${var.environment_name}-diego-ssh-rule"
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
  name                = "${var.environment_name}-diego-ssh-ntp-rule"
  resource_group_name = azurerm_resource_group.platform.name
  loadbalancer_id     = azurerm_lb.diego-ssh.id

  frontend_ip_configuration_name = "frontendip"
  protocol                       = "UDP"
  frontend_port                  = "123"
  backend_port                   = "123"

  backend_address_pool_id = azurerm_lb_backend_address_pool.diego-ssh.id
}

# PKS API
resource "azurerm_public_ip" "pks-lb" {
  name                = "${var.environment_name}-pks-lb-ip"
  location            = var.location
  resource_group_name = azurerm_resource_group.platform.name
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = merge(
    var.tags,
    { name = "${var.environment_name}-pks-lb-ip" },
  )
}

resource "azurerm_lb" "pks" {
  name                = "${var.environment_name}-pks-lb"
  location            = var.location
  sku                 = "Standard"
  resource_group_name = azurerm_resource_group.platform.name

  frontend_ip_configuration {
    name                 = azurerm_public_ip.pks-lb.name
    public_ip_address_id = azurerm_public_ip.pks-lb.id
  }

  tags = merge(
    var.tags,
    { name = "${var.environment_name}-pks-lb" },
  )
}

resource "azurerm_lb_backend_address_pool" "pks-lb" {
  name                = "${var.environment_name}-pks-backend-pool"
  resource_group_name = azurerm_resource_group.platform.name
  loadbalancer_id     = azurerm_lb.pks.id
}

resource "azurerm_lb_probe" "pks-lb-uaa" {
  name                = "${var.environment_name}-pks-lb-uaa-health-probe"
  resource_group_name = azurerm_resource_group.platform.name
  loadbalancer_id     = azurerm_lb.pks.id
  protocol            = "Tcp"
  interval_in_seconds = 5
  number_of_probes    = 2
  port                = 8443
}

resource "azurerm_lb_rule" "pks-lb-uaa" {
  name                           = "${var.environment_name}-pks-lb-uaa-rule"
  resource_group_name            = azurerm_resource_group.platform.name
  loadbalancer_id                = azurerm_lb.pks.id
  protocol                       = "Tcp"
  frontend_port                  = 8443
  backend_port                   = 8443
  frontend_ip_configuration_name = azurerm_public_ip.pks-lb.name
  probe_id                       = azurerm_lb_probe.pks-lb-uaa.id
  backend_address_pool_id        = azurerm_lb_backend_address_pool.pks-lb.id
}

resource "azurerm_lb_probe" "pks-lb-api" {
  name                = "${var.environment_name}-pks-lb-api-health-probe"
  resource_group_name = azurerm_resource_group.platform.name
  loadbalancer_id     = azurerm_lb.pks.id
  protocol            = "Tcp"
  interval_in_seconds = 5
  number_of_probes    = 2
  port                = 9021
}

resource "azurerm_lb_rule" "pks-lb-api-rule" {
  name                           = "${var.environment_name}-pks-lb-api-rule"
  resource_group_name            = azurerm_resource_group.platform.name
  loadbalancer_id                = azurerm_lb.pks.id
  protocol                       = "Tcp"
  frontend_port                  = 9021
  backend_port                   = 9021
  frontend_ip_configuration_name = azurerm_public_ip.pks-lb.name
  probe_id                       = azurerm_lb_probe.pks-lb-api.id
  backend_address_pool_id        = azurerm_lb_backend_address_pool.pks-lb.id
}
