locals {
  tcp_ports = ["1024-1123"]
}

resource "google_compute_address" "tcp-lb" {
  name = "${var.environment_name}-tcp-lb"
}

resource "google_compute_forwarding_rule" "tcp-lb" {
  name        = "${var.environment_name}-tcp-lb-${count.index}"
  ip_address  = google_compute_address.tcp-lb.address
  target      = google_compute_target_pool.tcp-lb.self_link
  port_range  = element(local.tcp_ports, count.index)
  ip_protocol = "TCP"

  count = length(local.tcp_ports)
}

resource "google_compute_target_pool" "tcp-lb" {
  name = "${var.environment_name}-tcp-lb"

  health_checks = [google_compute_http_health_check.tcp-lb.name]
}

resource "google_compute_http_health_check" "tcp-lb" {
  name                = "${var.environment_name}-tcp-lb-health-check"
  port                = 80
  request_path        = "/health"
  check_interval_sec  = 30
  timeout_sec         = 5
  healthy_threshold   = 10
  unhealthy_threshold = 2
}
