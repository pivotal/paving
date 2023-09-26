locals {
  management_subnet_cidr = "10.0.0.0/26"
  pas_subnet_cidr        = "10.0.4.0/24"
  services_subnet_cidr   = "10.0.8.0/24"
  pks_subnet_cidr        = "10.0.10.0/24"
}

resource "google_compute_subnetwork" "management" {
  name          = "${var.environment_name}-management-subnet"
  ip_cidr_range = local.management_subnet_cidr
  network       = google_compute_network.network.self_link
  region        = var.region

  log_config {
    aggregation_interval = "INTERVAL_15_MIN"
    flow_sampling = "1.0"
    metadata = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "services" {
  name          = "${var.environment_name}-services-subnet"
  ip_cidr_range = local.services_subnet_cidr
  network       = google_compute_network.network.self_link
  region        = var.region

  log_config {
    aggregation_interval = "INTERVAL_15_MIN"
    flow_sampling = "1.0"
    metadata = "INCLUDE_ALL_METADATA"
  }
}

//NOTE: here because it is a requirement on the NAT
//      and terraform has no way of extending the NAT resource
resource "google_compute_subnetwork" "pks" {
  name          = "${var.environment_name}-pks-subnet"
  ip_cidr_range = local.pks_subnet_cidr
  network       = google_compute_network.network.self_link
  region        = var.region

  log_config {
    aggregation_interval = "INTERVAL_15_MIN"
    flow_sampling = "1.0"
    metadata = "INCLUDE_ALL_METADATA"
  }
}
