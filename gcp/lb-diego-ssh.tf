resource "google_compute_address" "ssh-lb" {
  name = "${var.environment_name}-ssh-lb"
}

resource "google_compute_forwarding_rule" "ssh-lb-2222" {
  name        = "${var.environment_name}-ssh-lb"
  ip_address  = google_compute_address.ssh-lb.address
  target      = google_compute_target_pool.ssh-lb.self_link
  port_range  = "2222"
  ip_protocol = "TCP"
}

resource "google_compute_target_pool" "ssh-lb" {
  name = "${var.environment_name}-ssh-lb"
}
