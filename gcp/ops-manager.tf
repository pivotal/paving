resource "google_compute_address" "ops-manager" {
  name = "${var.environment_name}-ops-manager-ip"
}

resource "tls_private_key" "ops-manager" {
  algorithm = "RSA"
  rsa_bits  = "4096"
}

resource "google_service_account" "opsman_service_account" {
  account_id   = "${var.environment_name}-opsman"
  display_name = "${var.environment_name} Ops Manager VM Service Account"
}

resource "google_service_account_key" "opsman_service_account_key" {
  service_account_id = google_service_account.opsman_service_account.id
}

resource "google_project_iam_member" "opsman_iam_service_account_user" {
  project = var.project
  role    = "roles/iam.serviceAccountUser"
  member  = "serviceAccount:${google_service_account.opsman_service_account.email}"
}

resource "google_project_iam_member" "opsman_iam_service_account_token_creator" {
  project = var.project
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:${google_service_account.opsman_service_account.email}"
}

resource "google_project_iam_member" "opsman_compute_instance_admin_v1" {
  project = var.project
  role    = "roles/compute.instanceAdmin.v1"
  member  = "serviceAccount:${google_service_account.opsman_service_account.email}"
}

resource "google_project_iam_member" "opsman_compute_network_admin" {
  project = var.project
  role    = "roles/compute.networkAdmin"
  member  = "serviceAccount:${google_service_account.opsman_service_account.email}"
}

resource "google_project_iam_member" "opsman_compute_storage_admin" {
  project = var.project
  role    = "roles/compute.storageAdmin"
  member  = "serviceAccount:${google_service_account.opsman_service_account.email}"
}

resource "google_project_iam_member" "opsman_storage_admin" {
  project = var.project
  role    = "roles/storage.admin"
  member  = "serviceAccount:${google_service_account.opsman_service_account.email}"
}

