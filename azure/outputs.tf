locals {
  stable_config = {
    tenant_id        = var.tenant_id
    subscription_id  = var.subscription_id
    client_id        = var.client_id
    client_secret    = var.client_secret
    location         = var.location
    environment_name = var.environment_name
    cloud_name       = var.cloud_name

    network_name        = azurerm_virtual_network.platform.name
    resource_group_name = azurerm_resource_group.platform.name

    management_subnet_name    = azurerm_subnet.management.name
    management_subnet_id      = azurerm_subnet.management.id
    management_subnet_cidr    = azurerm_subnet.management.address_prefix
    management_subnet_gateway = cidrhost(azurerm_subnet.management.address_prefix, 1)
    management_subnet_range   = cidrhost(azurerm_subnet.management.address_prefix, 10)

    bosh_storage_account_name = azurerm_storage_account.bosh.name

    ops_manager_security_group_name  = azurerm_network_security_group.ops-manager.name
    ops_manager_ssh_private_key          = tls_private_key.ops_manager.private_key_pem
    ops_manager_ssh_public_key           = tls_private_key.ops_manager.public_key_openssh
    ops_manager_private_ip           = cidrhost(azurerm_subnet.management.address_prefix, 5)
    ops_manager_public_ip            = azurerm_public_ip.ops-manager.ip_address
    ops_manager_container_name       = azurerm_storage_container.ops-manager.name
    ops_manager_dns                  = "${azurerm_dns_a_record.ops-manager.name}.${azurerm_dns_a_record.ops-manager.zone_name}"
    ops_manager_storage_account_name = azurerm_storage_account.ops-manager.name

    iaas_configuration_environment_azurecloud = var.iaas_configuration_environment_azurecloud

    platform_vms_security_group_name = azurerm_network_security_group.platform-vms.name

    pas_subnet_name                = azurerm_subnet.pas.name
    pas_subnet_id                  = azurerm_subnet.pas.id
    pas_subnet_cidr                = azurerm_subnet.pas.address_prefix
    pas_subnet_gateway             = cidrhost(azurerm_subnet.pas.address_prefix, 1)
    pas_subnet_range               = cidrhost(azurerm_subnet.pas.address_prefix, 10)
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

    pks_as_name                                = azurerm_availability_set.pks_as.name
    pks_lb_name                                = azurerm_lb.pks.name
    pks_dns                                    = "${azurerm_dns_a_record.pks.name}.${azurerm_dns_a_record.pks.zone_name}"
    pks_subnet_name                            = azurerm_subnet.pks.name
    pks_subnet_id                              = azurerm_subnet.pks.id
    pks_subnet_cidr                            = azurerm_subnet.pks.address_prefix
    pks_subnet_gateway                         = cidrhost(azurerm_subnet.pks.address_prefix, 1)
    pks_subnet_range                           = cidrhost(azurerm_subnet.pks.address_prefix, 10)
    pks_api_application_security_group_name    = azurerm_application_security_group.pks-api.name
    pks_api_network_security_group_name        = azurerm_network_security_group.pks-api.name
    pks_internal_network_security_group_name   = azurerm_network_security_group.pks-internal.name
    pks_master_application_security_group_name = azurerm_application_security_group.pks-master.name
    pks_master_network_security_group_name     = azurerm_network_security_group.pks-master.name
    pks_master_managed_identity                = azurerm_user_assigned_identity.pks-master.name
    pks_worker_managed_identity                = azurerm_user_assigned_identity.pks-worker.name

    services_subnet_name    = azurerm_subnet.services.name
    services_subnet_id      = azurerm_subnet.services.id
    services_subnet_cidr    = azurerm_subnet.services.address_prefix
    services_subnet_gateway = cidrhost(azurerm_subnet.services.address_prefix, 1)
    services_subnet_range   = cidrhost(azurerm_subnet.services.address_prefix, 10)

    ssl_certificate = var.ssl_certificate
    ssl_private_key = var.ssl_private_key
  }
}

output "stable_config" {
  value     = jsonencode(local.stable_config)
  sensitive = true
}
