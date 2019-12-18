resource "google_compute_network" "network" {
  name                    = "${var.environment_name}-network"
  auto_create_subnetworks = false
}
