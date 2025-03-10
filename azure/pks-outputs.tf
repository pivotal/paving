locals {
  stable_config_pks = {
    pks_as_name                                = azurerm_availability_set.pks_as.name
    pks_lb_name                                = azurerm_lb.pks.name
    pks_dns                                    = "${azurerm_dns_a_record.pks.name}.${azurerm_dns_a_record.pks.zone_name}"
    pks_subnet_name                            = azurerm_subnet.pks.name
    pks_subnet_id                              = azurerm_subnet.pks.id
    pks_subnet_cidr                            = azurerm_subnet.pks.address_prefix
    pks_subnet_gateway                         = cidrhost(azurerm_subnet.pks.address_prefix, 1)
    pks_subnet_range                           = "${cidrhost(azurerm_subnet.pks.address_prefix, 1)}-${cidrhost(azurerm_subnet.pks.address_prefix, 10)}"
    pks_api_application_security_group_name    = azurerm_application_security_group.pks-api.name
    pks_api_network_security_group_name        = azurerm_network_security_group.pks-api.name
    pks_internal_network_security_group_name   = azurerm_network_security_group.pks-internal.name
    pks_master_application_security_group_name = azurerm_application_security_group.pks-master.name
    pks_master_network_security_group_name     = azurerm_network_security_group.pks-master.name
    pks_master_managed_identity                = azurerm_user_assigned_identity.pks-master.name
    pks_worker_managed_identity                = azurerm_user_assigned_identity.pks-worker.name
  }
}

output "stable_config_pks" {
  value     = jsonencode(local.stable_config_pks)
  sensitive = true
}
