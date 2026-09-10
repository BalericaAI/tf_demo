resource "google_service_account" "service_a" {
  account_id = "seir-1-490120"
}

resource "google_project_iam_member" "service_a_storage_admin" {
  project = "seir-1-490120"
  role    = "roles/storage.admin"
  member  = "serviceAccount:${google_service_account.service_a.email}"
}

resource "google_service_account_iam_member" "service_a_workload_identity" {
  service_account_id = google_service_account.service_a.id
  role               = "roles/iam.workloadIdentityUser"
  member             = "serviceAccount:seir-1-490120.svc.id.goog[staging/service-a]"
}


# 1. Define the Service Account
resource "google_service_account" "kubernetes" {
  account_id   = "kubernetes"
  display_name = "GKE Node Service Account"
  project      = "seir-1-490120"
}

# 2. Assign standard GKE node roles (Required for nodes to pull images and log)
resource "google_project_iam_member" "kubernetes_logging" {
  project = "seir-1-490120"
  role    = "roles/logging.logWriter"
  member  = "serviceAccount:${google_service_account.kubernetes.email}"
}

resource "google_project_iam_member" "kubernetes_monitoring" {
  project = "seir-1-490120"
  role    = "roles/monitoring.metricWriter"
  member  = "serviceAccount:${google_service_account.kubernetes.email}"
}

resource "google_project_iam_member" "kubernetes_registry" {
  project = "seir-1-490120"
  role    = "roles/storage.objectViewer"
  member  = "serviceAccount:${google_service_account.kubernetes.email}"
}

