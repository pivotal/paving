provider "google" {
  project     = var.project
  region      = var.region
  credentials = var.service_account_key
}

terraform {
  required_version = ">= 0.12.0"
}
