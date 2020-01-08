locals {
  stable_config = {
    nsxt_host = var.nsxt_host
  }
}

output "stable_config" {
  value     = jsonencode(local.stable_config)
  sensitive = true
}
