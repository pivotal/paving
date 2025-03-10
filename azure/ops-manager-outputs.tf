locals {
  stable_config_opsmanager = {
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
    management_subnet_range   = "${cidrhost(azurerm_subnet.management.address_prefix, 1)}-${cidrhost(azurerm_subnet.management.address_prefix, 10)}"

    bosh_storage_account_name = azurerm_storage_account.bosh.name

    ops_manager_security_group_name  = azurerm_network_security_group.ops-manager.name
    ops_manager_ssh_private_key      = tls_private_key.ops_manager.private_key_pem
    ops_manager_ssh_public_key       = tls_private_key.ops_manager.public_key_openssh
    ops_manager_private_ip           = cidrhost(azurerm_subnet.management.address_prefix, 5)
    ops_manager_public_ip            = azurerm_public_ip.ops-manager.ip_address
    ops_manager_container_name       = azurerm_storage_container.ops-manager.name
    ops_manager_dns                  = "${azurerm_dns_a_record.ops-manager.name}.${azurerm_dns_a_record.ops-manager.zone_name}"
    ops_manager_storage_account_name = azurerm_storage_account.ops-manager.name

    iaas_configuration_environment_azurecloud = var.iaas_configuration_environment_azurecloud

    platform_vms_security_group_name = azurerm_network_security_group.platform-vms.name

    services_subnet_name    = azurerm_subnet.services.name
    services_subnet_id      = azurerm_subnet.services.id
    services_subnet_cidr    = azurerm_subnet.services.address_prefix
    services_subnet_gateway = cidrhost(azurerm_subnet.services.address_prefix, 1)
    services_subnet_range   = "${cidrhost(azurerm_subnet.services.address_prefix, 1)}-${cidrhost(azurerm_subnet.services.address_prefix, 10)}"

    ssl_certificate = var.ssl_certificate
    ssl_private_key = var.ssl_private_key
  }
}

output "stable_config_opsmanager" {
  value     = jsonencode(local.stable_config_opsmanager)
  sensitive = true
}
