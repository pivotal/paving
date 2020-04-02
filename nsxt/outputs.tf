locals {
  stable_config = {
    environment_name = var.environment_name
    
    nsxt_host     = var.nsxt_host
    nsxt_username = var.nsxt_username
    nsxt_password = var.nsxt_password
    nsxt_ca_cert  = var.nsxt_ca_cert

    vcenter_datacenter    = var.vcenter_datacenter
    vcenter_datastore     = var.vcenter_datastore
    vcenter_host          = var.vcenter_host
    vcenter_username      = var.vcenter_username
    vcenter_password      = var.vcenter_password
    vcenter_resource_pool = var.vcenter_resource_pool
    vcenter_cluster       = var.vcenter_cluster

    ops_manager_ntp             = var.ops_manager_ntp
    ops_manager_netmask         = var.ops_manager_netmask
    ops_manager_dns             = var.ops_manager_dns
    ops_manager_dns_servers     = var.ops_manager_dns_servers
    ops_manager_folder          = var.ops_manager_folder
    ops_manager_ssh_public_key  = tls_private_key.ops-manager.public_key_openssh
    ops_manager_ssh_private_key = tls_private_key.ops-manager.private_key_pem
    ops_manager_public_ip       = var.ops_manager_public_ip
    ops_manager_private_ip      = nsxt_nat_rule.dnat_om.translated_network

    management_subnet_name               = nsxt_logical_switch.infrastructure_ls.display_name
    management_subnet_cidr               = "${var.subnet_prefix}.1.0/24"
    management_subnet_gateway            = "${var.subnet_prefix}.1.1"
    management_subnet_reserved_ip_ranges = "${var.subnet_prefix}.1.1-${var.subnet_prefix}.1.10"

    allow_unverified_ssl      = var.allow_unverified_ssl
    disable_ssl_verification  = !var.allow_unverified_ssl

    lb_pool_web = nsxt_lb_pool.pas-web.display_name
    lb_pool_tcp = nsxt_lb_pool.pas-tcp.display_name
    lb_pool_ssh = nsxt_lb_pool.pas-ssh.display_name
  }
}

output "stable_config" {
  value     = jsonencode(local.stable_config)
  sensitive = true
}
