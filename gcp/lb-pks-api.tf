resource "google_compute_address" "pks-api-lb" {
  name = "${var.environment_name}-pks-api-lb"
}

resource "google_compute_forwarding_rule" "pks-api-lb-9021" {
  name        = "${var.environment_name}-pks-api-lb-9021"
  ip_address  = google_compute_address.pks-api-lb.address
  target      = google_compute_target_pool.pks-api-lb.self_link
  port_range  = "9021"
  ip_protocol = "TCP"
}

resource "google_compute_forwarding_rule" "pks-api-lb-8443" {
  name        = "${var.environment_name}-pks-api-lb-8443"
  ip_address  = google_compute_address.pks-api-lb.address
  target      = google_compute_target_pool.pks-api-lb.self_link
  port_range  = "8443"
  ip_protocol = "TCP"
}

resource "google_compute_target_pool" "pks-api-lb" {
  name = "${var.environment_name}-pks-api-lb"
}
