# HTTP/S
resource "google_compute_backend_service" "http-lb" {
  name        = "${var.environment_name}-http-lb"
  port_name   = "http"
  protocol    = "HTTP"
  timeout_sec = 900
  enable_cdn  = false

  backend {
    group = google_compute_instance_group.http-lb[0].self_link
  }

  backend {
    group = google_compute_instance_group.http-lb[1].self_link
  }

  health_checks = [google_compute_http_health_check.http-lb.self_link]
}

resource "google_compute_instance_group" "http-lb" {
  name = "${var.environment_name}-http-lb-${count.index}"
  zone = element(var.availability_zones, count.index)

  count = length(var.availability_zones)
}

resource "google_compute_global_address" "http-lb" {
  name = "${var.environment_name}-http-lb"
}

resource "google_compute_url_map" "https-lb" {
  name = "${var.environment_name}-https-lb"

  default_service = google_compute_backend_service.http-lb.self_link
}

resource "google_compute_target_http_proxy" "http-lb" {
  name    = "${var.environment_name}-http-lb"
  url_map = google_compute_url_map.https-lb.self_link
}

resource "google_compute_target_https_proxy" "https-lb" {
  name             = "${var.environment_name}-https-lb"
  url_map          = google_compute_url_map.https-lb.self_link
  ssl_certificates = [google_compute_ssl_certificate.certificate.self_link]
}

resource "google_compute_global_forwarding_rule" "http-lb-80" {
  name       = "${var.environment_name}-http-lb"
  ip_address = google_compute_global_address.http-lb.address
  target     = google_compute_target_http_proxy.http-lb.self_link
  port_range = "80"
}

resource "google_compute_global_forwarding_rule" "https-lb-443" {
  name       = "${var.environment_name}-https-lb"
  ip_address = google_compute_global_address.http-lb.address
  target     = google_compute_target_https_proxy.https-lb.self_link
  port_range = "443"
}

resource "google_compute_http_health_check" "http-lb" {
  name                = "${var.environment_name}-http-lb-health-check"
  port                = 8080
  request_path        = "/health"
  check_interval_sec  = 5
  timeout_sec         = 3
  healthy_threshold   = 6
  unhealthy_threshold = 3
}

# SSH
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

# TCP
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

# Web
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

# PKS API
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
