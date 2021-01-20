locals {
  stable_config_pas = {
    lb_pool_web = nsxt_policy_lb_pool.pas-web.display_name
    lb_pool_tcp = nsxt_policy_lb_pool.pas-tcp.display_name
    lb_pool_ssh = nsxt_policy_lb_pool.pas-ssh.display_name
  }
}

output "stable_config_pas" {
  value     = jsonencode(local.stable_config_pas)
  sensitive = true
}
