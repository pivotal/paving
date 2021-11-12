resource "google_compute_backend_service" "http-lb" {
  protocol    = "HTTP2"
}
