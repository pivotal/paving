locals {
  stable_config = {
    project = var.project
    region  = var.region

    network_id = google_compute_network.network.name

    ops_manager_service_account_key = google_service_account_key.ops-manager.private_key
    ops_manager_public_ip           = google_compute_address.ops-manager.address
    ops_manager_ssh_public_key      = tls_private_key.ops-manager.public_key_openssh
    ops_manager_ssh_private_key     = tls_private_key.ops-manager.private_key_pem

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
