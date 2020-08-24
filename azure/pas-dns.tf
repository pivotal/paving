resource "azurerm_dns_a_record" "apps" {
  name                = "*.apps.${var.environment_name}"
  zone_name           = data.azurerm_dns_zone.hosted.name
  resource_group_name = data.azurerm_dns_zone.hosted.resource_group_name
  ttl                 = "60"
  records             = [azurerm_public_ip.web-lb.ip_address]

  tags = merge(
  var.tags,
  { name = "*.apps.${var.environment_name}" },
  )
}

resource "azurerm_dns_a_record" "sys" {
  name                = "*.sys.${var.environment_name}"
  zone_name           = data.azurerm_dns_zone.hosted.name
  resource_group_name = data.azurerm_dns_zone.hosted.resource_group_name
  ttl                 = "60"
  records             = [azurerm_public_ip.web-lb.ip_address]

  tags = merge(
  var.tags,
  { name = "*.sys.${var.environment_name}" },
  )
}

resource "azurerm_dns_a_record" "ssh" {
  name                = "ssh.sys.${var.environment_name}"
  zone_name           = data.azurerm_dns_zone.hosted.name
  resource_group_name = data.azurerm_dns_zone.hosted.resource_group_name
  ttl                 = "60"
  records             = [azurerm_public_ip.diego-ssh-lb.ip_address]

  tags = merge(
  var.tags,
  { name = "ssh.sys.${var.environment_name}" },
  )
}

resource "azurerm_dns_a_record" "mysql" {
  name                = "mysql.${var.environment_name}"
  zone_name           = data.azurerm_dns_zone.hosted.name
  resource_group_name = data.azurerm_dns_zone.hosted.resource_group_name
  ttl                 = "60"
  records             = [azurerm_lb.mysql.private_ip_address]

  tags = merge(
  var.tags,
  { name = "mysql.${var.environment_name}" },
  )
}

resource "azurerm_dns_a_record" "tcp" {
  name                = "tcp.${var.environment_name}"
  zone_name           = data.azurerm_dns_zone.hosted.name
  resource_group_name = data.azurerm_dns_zone.hosted.resource_group_name
  ttl                 = "60"
  records             = [azurerm_public_ip.tcp-lb.ip_address]

  tags = merge(
  var.tags,
  { name = "tcp.${var.environment_name}" },
  )
}
