resource "google_compute_address" "nat-address" {
  name   = "${var.environment_name}-cloud-nat"
  region = var.region
}

resource "google_compute_router" "nat-router" {
  name    = "${var.environment_name}-nat-router"
  region  = var.region
  network = google_compute_network.network.self_link

  bgp {
    asn = 64514
  }
}

resource "google_compute_router_nat" "nat" {
  name                               = "${var.environment_name}-cloud-nat"
  router                             = google_compute_router.nat-router.name
  region                             = var.region
  nat_ip_allocate_option             = "MANUAL_ONLY"
  nat_ips                            = [google_compute_address.nat-address.self_link]
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"

  subnetwork {
    name                    = google_compute_subnetwork.pks.self_link
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }

  subnetwork {
    name                    = google_compute_subnetwork.services.self_link
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
}

