locals {
  stable_config_pas = {
    pas_subnet_name = google_compute_subnetwork.pas.name
    pas_subnet_cidr = google_compute_subnetwork.pas.ip_cidr_range
    pas_subnet_gateway = google_compute_subnetwork.pas.gateway_address
    pas_subnet_reserved_ip_ranges = "${cidrhost(google_compute_subnetwork.pas.ip_cidr_range, 1)}-${cidrhost(google_compute_subnetwork.pas.ip_cidr_range, 9)}"

    buildpacks_bucket_name = google_storage_bucket.buildpacks.name
    droplets_bucket_name = google_storage_bucket.droplets.name
    packages_bucket_name = google_storage_bucket.packages.name
    resources_bucket_name = google_storage_bucket.resources.name
    backup_bucket_name = google_storage_bucket.backup.name

    http_backend_service_name = google_compute_backend_service.http-lb.name
    ssh_target_pool_name = google_compute_target_pool.ssh-lb.name
    tcp_target_pool_name = google_compute_target_pool.tcp-lb.name
    web_target_pool_name = google_compute_target_pool.websocket-lb.name

    sys_dns_domain = replace(replace(google_dns_record_set.wildcard-sys.name, "/\\.$/", ""), "*.", "")
    apps_dns_domain = replace(replace(google_dns_record_set.wildcard-apps.name, "/\\.$/", ""), "*.", "")
    doppler_dns = replace(google_dns_record_set.doppler-sys.name, "/\\.$/", "")
    loggregator_dns = replace(google_dns_record_set.loggregator-sys.name, "/\\.$/", "")
    ssh_dns = replace(google_dns_record_set.ssh.name, "/\\.$/", "")
    tcp_dns = replace(google_dns_record_set.tcp.name, "/\\.$/", "")
  }
}

output "stable_config_pas" {
  value = jsonencode(local.stable_config_pas)
  sensitive = true
}
