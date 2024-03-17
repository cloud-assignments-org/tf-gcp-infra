/**
google_project_iam_binding
https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project_iam#google_project_iam_binding
**/
resource "google_project_iam_binding" "logging_admin_role" {
  project = var.project_id
  role    = var.logging_admin_role

  members = [
    "serviceAccount:${google_service_account.ops_agent_service_account.email}"
  ]
}

/**
https://cloud.google.com/monitoring/access-control
**/
resource "google_project_iam_binding" "monitoring_metric_writer" {
  project = var.project_id
  role    = var.monitoring_metric_writer_role

  members = [
    "serviceAccount:${google_service_account.ops_agent_service_account.email}"
  ]
}
