resource "google_compute_ssl_certificate" "certificate" {
  name_prefix = "${var.environment_name}-cert"
  certificate = var.ssl_certificate
  private_key = var.ssl_private_key
}
