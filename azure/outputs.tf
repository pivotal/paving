locals {
  stable_config = {
    location         = var.location
    environment_name = var.environment_name

    network             = azurerm_virtual_network.platform.name
    resource_group_name = azurerm_resource_group.platform.name

    security_group_platform_vms_name = azurerm_network_security_group.platform-vms.name
    security_group_opsmanager_name   = azurerm_network_security_group.ops-manager.name
    security_group_pks_api_name      = azurerm_network_security_group.pks-api.name
    security_group_pks_internal_name = azurerm_network_security_group.pks-internal.name
    security_group_pks_master_name   = azurerm_network_security_group.pks-master.name

    application_security_group_pks_api_name    = azurerm_application_security_group.pks-api.name
    application_security_group_pks_master_name = azurerm_application_security_group.pks-master.name

    opsmanager_private_key = tls_private_key.ops_manager.private_key_pem
    opsmanager_public_key  = tls_private_key.ops_manager.public_key_openssh
    opsmanager_public_ip   = azurerm_public_ip.ops-manager.ip_address

    container_opsmanager_image = azurerm_storage_container.ops-manager.name
    container_pas_buildpacks   = azurerm_storage_container.pas-buildpacks.name
    container_pas_packages     = azurerm_storage_container.pas-packages.name
    container_pas_droplets     = azurerm_storage_container.pas-droplets.name
    container_pas_resources    = azurerm_storage_container.pas-resources.name

    storage_account_bosh       = azurerm_storage_account.bosh.name
    storage_account_opsmanager = azurerm_storage_account.ops-manager.name
    storage_account_pas        = azurerm_storage_account.pas.name

    storage_account_pas_access_key = azurerm_storage_account.pas.primary_access_key

    subnet_management_name    = azurerm_subnet.management.name
    subnet_management_id      = azurerm_subnet.management.id
    subnet_management_cidr    = azurerm_subnet.management.address_prefix
    subnet_management_gateway = cidrhost(azurerm_subnet.management.address_prefix, 1)

    subnet_pas_name    = azurerm_subnet.pas.name
    subnet_pas_id      = azurerm_subnet.pas.id
    subnet_pas_cidr    = azurerm_subnet.pas.address_prefix
    subnet_pas_gateway = cidrhost(azurerm_subnet.pas.address_prefix, 1)

    subnet_pks_name    = azurerm_subnet.pks.name
    subnet_pks_id      = azurerm_subnet.pks.id
    subnet_pks_cidr    = azurerm_subnet.pks.address_prefix
    subnet_pks_gateway = cidrhost(azurerm_subnet.pks.address_prefix, 1)

    subnet_services_name    = azurerm_subnet.services.name
    subnet_services_id      = azurerm_subnet.services.id
    subnet_services_cidr    = azurerm_subnet.services.address_prefix
    subnet_services_gateway = cidrhost(azurerm_subnet.services.address_prefix, 1)

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

    pks_as = azurerm_availability_set.pks_as.name
  }
}

output "stable_config" {
  value     = jsonencode(local.stable_config)
  sensitive = true
}
