resource "google_compute_subnetwork" "pas" {
  name          = "${var.environment_name}-pas-subnet"
  ip_cidr_range = local.pas_subnet_cidr
  network       = google_compute_network.network.self_link
  region        = var.region

  log_config {
    aggregation_interval = "INTERVAL_15_MIN"
    flow_sampling = "1.0"
    metadata = "INCLUDE_ALL_METADATA"
  }
}
