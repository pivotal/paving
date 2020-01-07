locals {
  stable_config = {

    subnet_management_name    = azurerm_subnet.management.name
    subnet_management_cidr    = azurerm_subnet.management.address_prefix
    subnet_management_gateway = cidrhost(azurerm_subnet.management.address_prefix, 1)
    subnet_pas_name           = azurerm_subnet.pas.name
    subnet_pas_cidr           = azurerm_subnet.pas.address_prefix
    subnet_pas_gateway        = cidrhost(azurerm_subnet.pas.address_prefix, 1)
    subnet_pks_name           = azurerm_subnet.pks.name
    subnet_pks_cidr           = azurerm_subnet.pks.address_prefix
    subnet_pks_gateway        = cidrhost(azurerm_subnet.pks.address_prefix, 1)
    subnet_services_name      = azurerm_subnet.services.name
    subnet_services_cidr      = azurerm_subnet.services.address_prefix
    subnet_services_gateway   = cidrhost(azurerm_subnet.services.address_prefix, 1)


    lb_web       = azurerm_lb.web.name
    lb_diego_ssh = azurerm_lb.diego-ssh.name
    lb_mysql     = azurerm_lb.mysql.name
    lb_tcp       = azurerm_lb.tcp.name
    lb_pks       = azurerm_lb.pks.name

    dns_opsmanager = "${azurerm_dns_a_record.opsmanager.name}.${azurerm_dns_a_record.opsmanager.zone_name}"
    dns_apps       = "${azurerm_dns_a_record.apps.name}.${azurerm_dns_a_record.apps.zone_name}"
    dns_pks        = "${azurerm_dns_a_record.pks.name}.${azurerm_dns_a_record.pks.zone_name}"
    dns_ssh        = "${azurerm_dns_a_record.ssh.name}.${azurerm_dns_a_record.ssh.zone_name}"
    dns_sys        = "${azurerm_dns_a_record.sys.name}.${azurerm_dns_a_record.sys.zone_name}"
    dns_tcp        = "${azurerm_dns_a_record.tcp.name}.${azurerm_dns_a_record.tcp.zone_name}"
    dns_mysql      = "${azurerm_dns_a_record.mysql.name}.${azurerm_dns_a_record.mysql.zone_name}"
  }
}

output "stable_config" {
  value     = jsonencode(local.stable_config)
  sensitive = true
}
