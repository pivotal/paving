locals {
  stable_config = {
    project            = var.project
    region             = var.region
    availability_zones = var.availability_zones

    network_name = google_compute_network.network.name

    dns_name_servers = data.google_dns_managed_zone.hosted-zone.name_servers

    infrastructure_subnet_name    = google_compute_subnetwork.infrastructure.name
    infrastructure_subnet_cidr    = google_compute_subnetwork.infrastructure.ip_cidr_range
    infrastructure_subnet_gateway = google_compute_subnetwork.infrastructure.gateway_address

    pas_subnet_name    = google_compute_subnetwork.pas.name
    pas_subnet_cidr    = google_compute_subnetwork.pas.ip_cidr_range
    pas_subnet_gateway = google_compute_subnetwork.pas.gateway_address

    services_subnet_name    = google_compute_subnetwork.services.name
    services_subnet_cidr    = google_compute_subnetwork.services.ip_cidr_range
    services_subnet_gateway = google_compute_subnetwork.services.gateway_address

    pks_subnet_name    = google_compute_subnetwork.pks.name
    pks_subnet_cidr    = google_compute_subnetwork.pks.ip_cidr_range
    pks_subnet_gateway = google_compute_subnetwork.pks.gateway_address

    ops_manager_service_account_key = google_service_account_key.ops-manager.private_key
    ops_manager_public_ip           = google_compute_address.ops-manager.address
    ops_manager_ssh_public_key      = tls_private_key.ops-manager.public_key_openssh
    ops_manager_ssh_private_key     = tls_private_key.ops-manager.private_key_pem

    http_backend_service = google_compute_backend_service.http-lb.name
    ssh_router_pool      = google_compute_target_pool.ssh-lb.name
    tcp_router_pool      = google_compute_target_pool.tcp-lb.name

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
