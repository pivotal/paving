# Allow HTTP/S access to Ops Manager from the outside world
resource "google_compute_firewall" "ops-manager" {
  name        = "${var.environment_name}-ops-manager"
  network     = google_compute_network.network.name
  target_tags = ["${var.environment_name}-ops-manager"]

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "443"]
  }
}

