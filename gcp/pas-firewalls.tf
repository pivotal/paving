resource "google_compute_firewall" "tcp-lb-health-check" {
  name    = "${var.environment_name}-tcp-lb-health-check"
  network = google_compute_network.network.name

  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]

  target_tags = ["${var.environment_name}-tcp-lb"]
}

resource "google_compute_firewall" "tcp-lb" {
  name    = "${var.environment_name}-tcp-lb-firewall"
  network = google_compute_network.network.name

  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["1024-65535"]
  }

  source_ranges = var.ingress_source_ranges

  target_tags = ["${var.environment_name}-tcp-lb"]
}

resource "google_compute_firewall" "websocket-lb-health-check" {
  name    = "${var.environment_name}-websocket-lb-health-check"
  network = google_compute_network.network.name

  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["8080"]
  }

  source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]

  target_tags = [google_compute_http_health_check.websocket-lb.name]
}

resource "google_compute_firewall" "websocket-lb" {
  name    = "${var.environment_name}-websocket-lb-firewall"
  network = google_compute_network.network.name

  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = var.ingress_source_ranges

  target_tags = ["${var.environment_name}-websocket-lb"]
}

resource "google_compute_firewall" "http-lb" {
  name    = "${var.environment_name}-http-lb-firewall"
  network = google_compute_network.network.self_link

  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = var.ingress_source_ranges

  target_tags = ["${var.environment_name}-http-lb"]
}
