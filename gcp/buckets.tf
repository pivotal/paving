resource "google_storage_bucket" "ops-manager" {
  name          = "${var.project}-${var.environment_name}-ops-manager"
  force_destroy = true
}
