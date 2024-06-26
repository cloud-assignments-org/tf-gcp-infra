/**
google_project_iam_binding
https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project_iam#google_project_iam_binding
**/
resource "google_project_iam_binding" "logging_admin_role" {
  project = var.project_id
  role    = var.logging_admin_role

  members = [
    "serviceAccount:${google_service_account.compute_instance_service_account.email}"
  ]
}

/**
https://cloud.google.com/monitoring/access-control
**/
resource "google_project_iam_binding" "monitoring_metric_writer" {
  project = var.project_id
  role    = var.monitoring_metric_writer_role

  members = [
    "serviceAccount:${google_service_account.compute_instance_service_account.email}"
  ]
}

resource "google_project_iam_binding" "pub_sub_publisher" {
  project = var.project_id
  role    = var.pub_sub_publisher_role

  members = [
    "serviceAccount:${google_service_account.compute_instance_service_account.email}"
  ]
}

# FOR KMS
# Refer: https://cloud.google.com/compute/docs/disks/customer-managed-encryption
resource "google_project_iam_binding" "crypto_key_encrypter_decrypter" {
  project = var.project_id
  role    = var.crypto_key_encrypter_decrypter_role

  members = [
    "serviceAccount:service-${var.project_number}@compute-system.iam.gserviceaccount.com"

  ]
}

# We need to provide both the toke creator and the cloud functions invoker role 
# to the pubsub service account
# This service account will be used to trigger the cloud function
resource "google_project_iam_binding" "service_acc_token_creator" {
  project = var.project_id
  role    = var.service_acc_token_creator_role

  members = [
    "serviceAccount:${google_service_account.pub_sub_service_account.email}"
  ]
}


# https://cloud.google.com/run/docs/troubleshooting#unauthorized-client
# we are facing the following issue: 
# textPayload: "The request was not authenticated. Either allow unauthenticated invocations or set the proper Authorization header. Read more at https://cloud.google.com/run/docs/securing/authenticating Additional troubleshooting documentation can be found at: https://cloud.google.com/run/docs/troubleshooting#unauthorized-client"

# we need to provide the following role instead of the cloudfunctions.invoker role
# roles/run.invoker
resource "google_project_iam_binding" "cloud_functions_invoker" {
  project = var.project_id
  role    = var.cloud_functions_run_invoker_role
  members = [
    "serviceAccount:${google_service_account.pub_sub_service_account.email}"
  ]
}


# For adding CMEK to SQL
resource "google_kms_crypto_key_iam_binding" "crypto_key" {
  crypto_key_id = google_kms_crypto_key.sql.id
  role          = var.crypto_key_encrypter_decrypter_role

  members = [
    "serviceAccount:${google_project_service_identity.gcp_sa_cloud_sql.email}",
  ]
}

# For adding CMEK to Cloud Storage
resource "google_kms_crypto_key_iam_binding" "binding" {
  crypto_key_id = google_kms_crypto_key.storage.id
  role          = var.crypto_key_encrypter_decrypter_role

  members = ["serviceAccount:${data.google_storage_project_service_account.gcs_account.email_address}"]
}
