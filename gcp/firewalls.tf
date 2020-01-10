resource "google_compute_firewall" "ops-manager" {
  name    = "${var.environment_name}-ops-manager"
  network = google_compute_network.network.name

  direction = "INGRESS"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "443"]
  }

  target_tags = ["${var.environment_name}-ops-manager"]
}

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
    local.management_subnet_cidr,
    local.pas_subnet_cidr,
    local.services_subnet_cidr,
    local.pks_subnet_cidr,
  ]
}

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

  target_tags = ["${var.environment_name}-http-lb"]
}

resource "google_compute_firewall" "pks-api-lb" {
  name    = "${var.environment_name}-pks-api-lb-firewall"
  network = google_compute_network.network.name

  direction = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["8443", "9021"]
  }

  target_tags = ["${var.environment_name}-pks-api-lb"]
}
