resource "google_compute_firewall" "pks-api-lb" {
  name    = "${var.environment_name}-pks-api-lb-firewall"
  network = google_compute_network.network.name

  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["8443", "9021"]
  }

  source_ranges = var.ingress_source_ranges

  target_tags = ["${var.environment_name}-pks-api-lb"]
}
