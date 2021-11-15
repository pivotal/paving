resource "random_integer" "bucket_suffix" {
  min = 1
  max = 100000
}

resource "google_storage_bucket" "ops-manager" {
  name          = "${var.project}-${var.environment_name}-ops-manager-${random_integer.bucket_suffix.result}"
  force_destroy = true
  location = var.location
}
