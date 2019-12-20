locals {
  stable_config = {
    project            = var.project
    region             = var.region
    availability_zones = var.availability_zones

    network_name = google_compute_network.network.name

    dns_name_servers = data.google_dns_managed_zone.hosted-zone.name_servers

    subnet_management_name    = google_compute_subnetwork.management.name
    subnet_management_cidr    = google_compute_subnetwork.management.ip_cidr_range
    subnet_management_gateway = google_compute_subnetwork.management.gateway_address

    subnet_pas_name    = google_compute_subnetwork.pas.name
    subnet_pas_cidr    = google_compute_subnetwork.pas.ip_cidr_range
    subnet_pas_gateway = google_compute_subnetwork.pas.gateway_address

    subnet_services_name    = google_compute_subnetwork.services.name
    subnet_services_cidr    = google_compute_subnetwork.services.ip_cidr_range
    subnet_services_gateway = google_compute_subnetwork.services.gateway_address

    subnet_pks_name    = google_compute_subnetwork.pks.name
    subnet_pks_cidr    = google_compute_subnetwork.pks.ip_cidr_range
    subnet_pks_gateway = google_compute_subnetwork.pks.gateway_address

    ops_manager_service_account_key = google_service_account_key.ops-manager.private_key
    ops_manager_public_ip           = google_compute_address.ops-manager.address
    ops_manager_ssh_public_key      = tls_private_key.ops-manager.public_key_openssh
    ops_manager_ssh_private_key     = tls_private_key.ops-manager.private_key_pem

    backend_service_http = google_compute_backend_service.http-lb.name
    target_pool_ssh      = google_compute_target_pool.ssh-lb.name
    target_pool_tcp      = google_compute_target_pool.tcp-lb.name
    target_pool_ws       = google_compute_target_pool.ws-lb.name

    dns_wildcard_sys    = google_dns_record_set.wildcard-sys.name
    dns_wildcard_apps   = google_dns_record_set.wildcard-apps.name
    dns_doppler_sys     = google_dns_record_set.doppler-sys.name
    dns_loggregator_sys = google_dns_record_set.loggregator-sys.name
    dns_ssh             = google_dns_record_set.ssh.name
    dns_tcp             = google_dns_record_set.tcp.name
    dns_ops_manager     = google_dns_record_set.ops-manager.name
    dns_pks_api         = google_dns_record_set.pks-api.name
  }
}

output "stable_config" {
  value     = jsonencode(local.stable_config)
  sensitive = true
}
