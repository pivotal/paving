resource "google_storage_bucket" "ops-manager" {
  name          = "${var.project}-${var.environment_name}-ops-manager"
  force_destroy = true
}

resource "google_storage_bucket" "buildpacks" {
  name          = "${var.project}-${var.environment_name}-buildpacks"
  force_destroy = true
}

resource "google_storage_bucket" "droplets" {
  name          = "${var.project}-${var.environment_name}-droplets"
  force_destroy = true
}

resource "google_storage_bucket" "packages" {
  name          = "${var.project}-${var.environment_name}-packages"
  force_destroy = true
}

resource "google_storage_bucket" "resources" {
  name          = "${var.project}-${var.environment_name}-resources"
  force_destroy = true
}

resource "google_storage_bucket" "backup" {
  name          = "${var.project}-${var.environment_name}-backup"
  force_destroy = true
}
