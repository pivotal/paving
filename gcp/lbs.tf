# SSH Load Balancer
resource "google_compute_address" "ssh-lb" {
  name = "${var.environment_name}-ssh-lb"
}

resource "google_compute_forwarding_rule" "lb" {
  name        = "${var.env_name}-${var.name}-lb-${count.index}"
  ip_address  = google_compute_address.lb[0].address
  target      = google_compute_target_pool.lb[0].self_link
  port_range  = element(var.forwarding_rule_ports, count.index)
  ip_protocol = "TCP"

  count = var.lb_count > 0 ? length(var.forwarding_rule_ports) : 0
}

resource "google_compute_target_pool" "lb" {
  name = var.lb_name

  health_checks = google_compute_http_health_check.lb.*.name

  count = var.lb_count
}


# GoRouter Load Balancer
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

  health_checks = google_compute_http_health_check.lb.*.self_link
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

resource "google_compute_global_forwarding_rule" "cf_http" {
  name       = "${var.environment_name}-http-lb"
  ip_address = google_compute_global_address.http-lb.address
  target     = google_compute_target_http_proxy.http-lb.self_link
  port_range = "80"
}

resource "google_compute_global_forwarding_rule" "https-lb" {
  name       = "${var.environment_name}-https-lb"
  ip_address = google_compute_global_address.http-lb.address
  target     = google_compute_target_https_proxy.https-lb.self_link
  port_range = "443"
}

resource "google_compute_http_health_check" "lb" {
  name                = "${var.environment_name}-health-check"
  port                = 8080
  request_path        = "/health"
  check_interval_sec  = 5
  timeout_sec         = 3
  healthy_threshold   = 6
  unhealthy_threshold = 3
}
