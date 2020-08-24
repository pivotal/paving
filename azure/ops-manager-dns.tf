data "azurerm_dns_zone" "hosted" {
  name = var.hosted_zone
}

resource "azurerm_dns_a_record" "ops-manager" {
  name                = "opsmanager.${var.environment_name}"
  zone_name           = data.azurerm_dns_zone.hosted.name
  resource_group_name = data.azurerm_dns_zone.hosted.resource_group_name
  ttl                 = "60"
  records             = [azurerm_public_ip.ops-manager.ip_address]

  tags = merge(
    var.tags,
    { name = "opsmanager.${var.environment_name}" },
  )
}
