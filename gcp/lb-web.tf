resource "google_compute_address" "websocket-lb" {
  name = "${var.environment_name}-websocket-lb"
}

resource "google_compute_forwarding_rule" "websocket-lb-80" {
  name        = "${var.environment_name}-websocket-lb-80"
  ip_address  = google_compute_address.websocket-lb.address
  target      = google_compute_target_pool.websocket-lb.self_link
  port_range  = "80"
  ip_protocol = "TCP"
}

resource "google_compute_forwarding_rule" "websocket-lb-443" {
  name        = "${var.environment_name}-websocket-lb-443"
  ip_address  = google_compute_address.websocket-lb.address
  target      = google_compute_target_pool.websocket-lb.self_link
  port_range  = "443"
  ip_protocol = "TCP"
}

resource "google_compute_target_pool" "websocket-lb" {
  name = "${var.environment_name}-websocket-lb"

  health_checks = [google_compute_http_health_check.websocket-lb.self_link]
}

resource "google_compute_http_health_check" "websocket-lb" {
  name                = "${var.environment_name}-websocket-lb"
  port                = 8080
  request_path        = "/health"
  check_interval_sec  = 5
  timeout_sec         = 3
  healthy_threshold   = 6
  unhealthy_threshold = 3
}
