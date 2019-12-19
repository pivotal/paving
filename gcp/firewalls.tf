resource "google_compute_firewall" "internal" {
  name    = "${var.environment_name}-internal"
  network = google_compute_network.network.self_link

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
  }

  allow {
    protocol = "udp"
  }

  source_ranges = [
    local.infrastructure_subnet_cidr,
    local.pas_subnet_cidr,
    local.services_subnet_cidr,
    local.pks_subnet_cidr,
  ]
}

