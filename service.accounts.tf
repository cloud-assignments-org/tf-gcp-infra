/**
https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_service_account
**/
# We need to create one single service account that has
# all the required roles for this instance
resource "google_service_account" "compute_instance_service_account" {
  account_id   = var.compute_instance_service_acc_id
  display_name = var.compute_instance_service_acc_display_name
}

resource "google_service_account" "pub_sub_service_account" {
  account_id   = var.pub_sub_service_account_id
  display_name = var.pub_sub_service_account_disp_name
}

# FOR Adding CMEK to SQL
resource "google_project_service_identity" "gcp_sa_cloud_sql" {
  provider = google-beta
  service  = "sqladmin.googleapis.com"
}


# For adding CMEK to Cloud Storage
data "google_storage_project_service_account" "gcs_account" {
}

