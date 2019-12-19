resource "google_compute_address" "ops-manager" {
  name = "${var.environment_name}-ops-manager-ip"
}


