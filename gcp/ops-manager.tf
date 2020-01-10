resource "google_compute_address" "ops-manager" {
  name = "${var.environment_name}-ops-manager-ip"
}

resource "tls_private_key" "ops-manager" {
  algorithm = "RSA"
  rsa_bits  = "4096"
}
