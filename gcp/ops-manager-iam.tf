resource "google_service_account" "ops-manager" {
  account_id   = "${var.environment_name}-ops-manager"
  display_name = "${var.environment_name} Ops Manager VM Service Account"
}

resource "google_service_account_key" "ops-manager" {
  service_account_id = google_service_account.ops-manager.id
}

resource "google_project_iam_member" "iam-service-account-user" {
  project = var.project
  role    = "roles/iam.serviceAccountUser"
  member  = "serviceAccount:${google_service_account.ops-manager.email}"
}

resource "google_project_iam_member" "iam-service-account-token-creator" {
  project = var.project
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:${google_service_account.ops-manager.email}"
}

resource "google_project_iam_member" "compute-instance-admin-v1" {
  project = var.project
  role    = "roles/compute.instanceAdmin.v1"
  member  = "serviceAccount:${google_service_account.ops-manager.email}"
}

resource "google_project_iam_member" "compute-network-admin" {
  project = var.project
  role    = "roles/compute.networkAdmin"
  member  = "serviceAccount:${google_service_account.ops-manager.email}"
}

resource "google_project_iam_member" "compute-storage-admin" {
  project = var.project
  role    = "roles/compute.storageAdmin"
  member  = "serviceAccount:${google_service_account.ops-manager.email}"
}

resource "google_project_iam_member" "storage-admin" {
  project = var.project
  role    = "roles/storage.admin"
  member  = "serviceAccount:${google_service_account.ops-manager.email}"
}
