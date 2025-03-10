locals {
  stable_config_pas = {
    pas_subnet_name                = azurerm_subnet.pas.name
    pas_subnet_id                  = azurerm_subnet.pas.id
    pas_subnet_cidr                = azurerm_subnet.pas.address_prefix
    pas_subnet_gateway             = cidrhost(azurerm_subnet.pas.address_prefix, 1)
    pas_subnet_range               = "${cidrhost(azurerm_subnet.pas.address_prefix, 1)}-${cidrhost(azurerm_subnet.pas.address_prefix, 10)}"
    pas_buildpacks_container_name  = azurerm_storage_container.pas-buildpacks.name
    pas_packages_container_name    = azurerm_storage_container.pas-packages.name
    pas_droplets_container_name    = azurerm_storage_container.pas-droplets.name
    pas_resources_container_name   = azurerm_storage_container.pas-resources.name
    pas_storage_account_name       = azurerm_storage_account.pas.name
    pas_storage_account_access_key = azurerm_storage_account.pas.primary_access_key

    web_lb_name   = azurerm_lb.web.name
    ssh_lb_name   = azurerm_lb.diego-ssh.name
    mysql_lb_name = azurerm_lb.mysql.name
    tcp_lb_name   = azurerm_lb.tcp.name

    apps_dns_domain = "${replace(azurerm_dns_a_record.apps.name, "*.", "")}.${azurerm_dns_a_record.apps.zone_name}"
    sys_dns_domain  = "${replace(azurerm_dns_a_record.sys.name, "*.", "")}.${azurerm_dns_a_record.sys.zone_name}"
    ssh_dns         = "${azurerm_dns_a_record.ssh.name}.${azurerm_dns_a_record.ssh.zone_name}"
    tcp_dns         = "${azurerm_dns_a_record.tcp.name}.${azurerm_dns_a_record.tcp.zone_name}"
    mysql_dns       = "${azurerm_dns_a_record.mysql.name}.${azurerm_dns_a_record.mysql.zone_name}"
  }
}

output "stable_config_pas" {
  value     = jsonencode(local.stable_config_pas)
  sensitive = true
}
