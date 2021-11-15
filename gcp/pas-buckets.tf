resource "google_storage_bucket" "buildpacks" {
  name          = "${var.project}-${var.environment_name}-buildpacks-${random_integer.bucket_suffix.result}"
  force_destroy = true
  location = var.location
}

resource "google_storage_bucket" "droplets" {
  name          = "${var.project}-${var.environment_name}-droplets-${random_integer.bucket_suffix.result}"
  force_destroy = true
  location = var.location
}

resource "google_storage_bucket" "packages" {
  name          = "${var.project}-${var.environment_name}-packages-${random_integer.bucket_suffix.result}"
  force_destroy = true
  location = var.location
}

resource "google_storage_bucket" "resources" {
  name          = "${var.project}-${var.environment_name}-resources-${random_integer.bucket_suffix.result}"
  force_destroy = true
  location = var.location
}

resource "google_storage_bucket" "backup" {
  name          = "${var.project}-${var.environment_name}-backup-${random_integer.bucket_suffix.result}"
  force_destroy = true
  location = var.location
}
