locals {
  stable_config = {
    project = var.project
    region  = var.region

    network_id = google_compute_network.network.name

    wildcard_sys_dns    = google_dns_record_set.wildcard-sys.name
    wildcard_apps_dns   = google_dns_record_set.wildcard-apps.name
    doppler_sys_dns     = google_dns_record_set.doppler-sys.name
    loggregator_sys_dns = google_dns_record_set.loggregator-sys.name
    ssh_dns             = google_dns_record_set.ssh.name
    tcp_dns             = google_dns_record_set.tcp.name
    ops_manager_dns     = google_dns_record_set.ops-manager.name
    pks_api_dns         = google_dns_record_set.pks-api.name
  }
}

output "stable_config" {
  value     = jsonencode(local.stable_config)
  sensitive = true
}
