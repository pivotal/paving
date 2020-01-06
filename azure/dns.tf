resource "azurerm_dns_a_record" "ops_manager_dns" {
  name                = "opsmanager"
  zone_name           = var.hosted_zone
  resource_group_name = azurerm_resource_group.platform.name
  ttl                 = "60"
  records             = [azurerm_public_ip.ops-manager.ip_address]
}

resource "azurerm_dns_a_record" "apps" {
  name                = "*.apps"
  zone_name           = var.hosted_zone
  resource_group_name = azurerm_resource_group.platform.name
  ttl                 = "60"
  records             = [azurerm_public_ip.web-lb.ip_address]
}

resource "azurerm_dns_a_record" "sys" {
  name                = "*.sys"
  zone_name           = var.hosted_zone
  resource_group_name = azurerm_resource_group.platform.name
  ttl                 = "60"
  records             = [azurerm_public_ip.web-lb.ip_address]
}

resource "azurerm_dns_a_record" "ssh" {
  name                = "ssh.sys"
  zone_name           = var.hosted_zone
  resource_group_name = azurerm_resource_group.platform.name
  ttl                 = "60"
  records             = [azurerm_public_ip.diego-ssh-lb.ip_address]
}

resource "azurerm_dns_a_record" "mysql" {
  name                = "mysql"
  zone_name           = var.hosted_zone
  resource_group_name = azurerm_resource_group.platform.name
  ttl                 = "60"
  records             = [azurerm_lb.mysql.private_ip_address]
}

resource "azurerm_dns_a_record" "tcp" {
  name                = "tcp"
  zone_name           = var.hosted_zone
  resource_group_name = azurerm_resource_group.platform.name
  ttl                 = "60"
  records             = [azurerm_public_ip.tcp-lb.ip_address]
}

resource "azurerm_dns_a_record" "pks" {
  name                = "pks"
  zone_name           = var.hosted_zone
  resource_group_name = azurerm_resource_group.platform.name
  ttl                 = "60"
  records             = [azurerm_public_ip.pks-lb.ip_address]
}
