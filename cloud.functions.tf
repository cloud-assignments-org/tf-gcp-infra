# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloudfunctions2_function
data "google_storage_bucket_object" "cloud_fn_source" {
  name   = "trigger-user-verification-email.zip"
  bucket = "cloud-dev-project-417513-bucket"
}

resource "random_string" "cloud_fn_random_suffix" {
  length           = 5
  special          = false
  override_special = "/@£$"
}

resource "google_cloudfunctions2_function" "trigger_user_verification_email_fn" {
  name        = "trigger-user-verificaiton-email-${random_string.cloud_fn_random_suffix.result}"
  location    = var.region
  description = "This function triggers an email to users to have their user name validated"

  depends_on = [data.google_storage_bucket_object.cloud_fn_source, 
  google_vpc_access_connector.connector
  ]

  build_config {
    runtime     = "nodejs20"
    entry_point = "triggerUserVerificationEmail" # Set the entry point 
    source {
      storage_source {
        bucket = data.google_storage_bucket_object.cloud_fn_source.bucket
        object = data.google_storage_bucket_object.cloud_fn_source.name
      }
    }
  }

  service_config {
    max_instance_count               = 1
    min_instance_count               = 0
    available_memory                 = "256Mi"
    timeout_seconds                  = 60
    max_instance_request_concurrency = 1
    available_cpu                    = "0.167"
    environment_variables = {
      PROTOCOL               = "http"
      DOMAIN                 = "parthadhruv.com"
      API_PORT               = "3000"
      VERSION                = "v1"
      VERIFY_END_POINT       = "user/verifyEmail"
      SET_VALIDITY_END_POINT = "user/setValidity"
      VALIDITY_MINUTES       = "2"
      MAILCHIMP_API_KEY      = "md-yz6F3wdSdOFqPdtTPVQFLQ"
      DATABASE_USER     = "${google_sql_user.user.name}"
      DATABASE_PASSWORD = "${google_sql_user.user.password}"
      DATABASE_IP       = "${google_sql_database_instance.instance.private_ip_address}"
      DB_PORT           = "${var.db_port}"
      DB_NAME           = "${google_sql_database.database.name}"

    }
    vpc_connector = google_vpc_access_connector.connector.self_link
    vpc_connector_egress_settings = "PRIVATE_RANGES_ONLY"

    ingress_settings               = "ALLOW_INTERNAL_ONLY"
    all_traffic_on_latest_revision = true
  }

  event_trigger {
    event_type            = "google.cloud.pubsub.topic.v1.messagePublished"
    pubsub_topic          = google_pubsub_topic.user-created.id
    service_account_email = google_service_account.pub_sub_service_account.email
  }
}

output "google_cloudfunctions2_function_name" {
  value = google_cloudfunctions2_function.trigger_user_verification_email_fn.name
}
