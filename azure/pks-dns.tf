resource "azurerm_dns_a_record" "pks" {
  name                = "pks.${var.environment_name}"
  zone_name           = data.azurerm_dns_zone.hosted.name
  resource_group_name = data.azurerm_dns_zone.hosted.resource_group_name
  ttl                 = "60"
  records             = [azurerm_public_ip.pks-lb.ip_address]

  tags = merge(
  var.tags,
  { name = "pks.${var.environment_name}" },
  )
}
