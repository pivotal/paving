locals {
  stable_config_pks = {
    pks_subnet_name = google_compute_subnetwork.pks.name
    pks_subnet_cidr = google_compute_subnetwork.pks.ip_cidr_range
    pks_subnet_gateway = google_compute_subnetwork.pks.gateway_address
    pks_subnet_reserved_ip_ranges = "${cidrhost(google_compute_subnetwork.pks.ip_cidr_range, 1)}-${cidrhost(google_compute_subnetwork.pks.ip_cidr_range, 9)}"
    pks_master_node_service_account_id = google_service_account.pks-master-node-service-account.email
    pks_worker_node_service_account_id = google_service_account.pks-worker-node-service-account.email
    pks_api_target_pool_name = google_compute_target_pool.pks-api-lb.name
    pks_api_dns_domain = replace(replace(google_dns_record_set.pks-api.name, "/\\.$/", ""), "*.", "")
  }
}

output "stable_config_pks" {
  value = jsonencode(local.stable_config_pks)
  sensitive = true
}
