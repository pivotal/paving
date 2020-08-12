resource "google_service_account" "pks-master-node-service-account" {
  account_id   = "${var.environment_name}-pks-master"
  display_name = "${var.environment_name} PKS Service Account"
}

resource "google_service_account_key" "pks-master-node-service-account-key" {
  service_account_id = google_service_account.pks-master-node-service-account.id
}

resource "google_service_account" "pks-worker-node-service-account" {
  account_id   = "${var.environment_name}-pks-worker"
  display_name = "${var.environment_name} PKS Service Account"
}

resource "google_service_account_key" "pks-worker-node-service-account-key" {
  service_account_id = google_service_account.pks-worker-node-service-account.id
}

resource "google_project_iam_member" "pks-master-node-compute-instance-admin-v1" {
  project = var.project
  role    = "roles/compute.instanceAdmin.v1"
  member  = "serviceAccount:${google_service_account.pks-master-node-service-account.email}"
}

resource "google_project_iam_member" "pks-master-node-compute-network-admin" {
  project = var.project
  role    = "roles/compute.networkAdmin"
  member  = "serviceAccount:${google_service_account.pks-master-node-service-account.email}"
}

resource "google_project_iam_member" "pks-master-node-compute-storage-admin" {
  project = var.project
  role    = "roles/compute.storageAdmin"
  member  = "serviceAccount:${google_service_account.pks-master-node-service-account.email}"
}

resource "google_project_iam_member" "pks-master-node-compute-security-admin" {
  project = var.project
  role    = "roles/compute.securityAdmin"
  member  = "serviceAccount:${google_service_account.pks-master-node-service-account.email}"
}

resource "google_project_iam_member" "pks-master-node-iam-service-account-user" {
  project = var.project
  role    = "roles/iam.serviceAccountUser"
  member  = "serviceAccount:${google_service_account.pks-master-node-service-account.email}"
}

resource "google_project_iam_member" "pks-master-node-compute-viewer" {
  project = var.project
  role    = "roles/compute.viewer"
  member  = "serviceAccount:${google_service_account.pks-master-node-service-account.email}"
}

resource "google_project_iam_member" "pks-worker-node-compute-viewer" {
  project = var.project
  role    = "roles/compute.viewer"
  member  = "serviceAccount:${google_service_account.pks-worker-node-service-account.email}"
}

resource "google_project_iam_member" "pks-worker-node-storage-object-viewer" {
  project = var.project
  role    = "roles/storage.objectViewer"
  member  = "serviceAccount:${google_service_account.pks-worker-node-service-account.email}"
}

