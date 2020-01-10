locals {
  stable_config = {
    nsxt_host = var.nsxt_host

    lb_pool_web = nsxt_lb_pool.pas-web.display_name
    lb_pool_tcp = nsxt_lb_pool.pas-tcp.display_name
    lb_pool_ssh = nsxt_lb_pool.pas-ssh.display_name
  }
}

output "stable_config" {
  value     = jsonencode(local.stable_config)
  sensitive = true
}
