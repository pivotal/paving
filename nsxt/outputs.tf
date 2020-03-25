locals {
  stable_config = {
    nsxt_host = var.nsxt_host

    vcenter_datacenter = var.vcenter_datacenter
    vcenter_datastore = var.vcenter_datastore
    vcenter_host = var.vcenter_host
    vcenter_username = var.vcenter_username
    vcenter_password = var.vcenter_password
    vcenter_resource_pool = var.vcenter_resource_pool

    ops_manager_ntp = var.ops_manager_ntp
    ops_manager_netmask = var.ops_manager_netmask
    ops_manager_hostname = var.ops_manager_hostname
    ops_manager_dns = var.ops_manager_dns
    ops_manager_folder = var.ops_manager_folder
    ops_manager_gateway = cidrhost(nsxt_nat_rule.snat_vm.match_source_network, 1)
    ops_manager_ssh_public_key      = tls_private_key.ops-manager.public_key_openssh
    ops_manager_ssh_private_key     = tls_private_key.ops-manager.private_key_pem
    ops_manager_public_ip = var.ops_manager_public_ip

    management_subnet_name = nsxt_logical_switch.infrastructure_ls.display_name

    lb_pool_web = nsxt_lb_pool.pas-web.display_name
    lb_pool_tcp = nsxt_lb_pool.pas-tcp.display_name
    lb_pool_ssh = nsxt_lb_pool.pas-ssh.display_name
  }
}

output "stable_config" {
  value     = jsonencode(local.stable_config)
  sensitive = true
}
