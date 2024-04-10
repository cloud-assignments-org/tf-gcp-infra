resource "google_storage_bucket" "cloud_fn_source" {
  name = var.cloud_fn_source_bucket
  location = var.region

  encryption {
    default_kms_key_name = google_kms_crypto_key.storage.id
  }
}


# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloudfunctions2_function
data "google_storage_bucket_object" "cloud_fn_source" {
  name   = var.cloud_fn_source_name
  bucket = var.cloud_fn_source_bucket
}

resource "random_string" "cloud_fn_random_suffix" {
  length           = var.cloud_fn_random_suffix_len
  special          = var.cloud_fn_random_suffix_spl
  override_special = var.cloud_fn_random_suffix_ovRide_special
}

resource "google_cloudfunctions2_function" "trigger_user_verification_email_fn" {
  name        = "${var.trigger_user_verification_email_fn_prefix}-${random_string.cloud_fn_random_suffix.result}"
  location    = var.region
  description = var.trigger_user_verification_email_fn_description

  depends_on = [data.google_storage_bucket_object.cloud_fn_source,
    google_vpc_access_connector.connector
  ]

  build_config {
    runtime     = var.build_config_runtime
    entry_point = var.build_config_entrypoint # Set the entry point 
    source {
      storage_source {
        bucket = data.google_storage_bucket_object.cloud_fn_source.bucket
        object = data.google_storage_bucket_object.cloud_fn_source.name
      }
    }
  }

  service_config {
    max_instance_count               = var.fn_max_instance_count
    min_instance_count               = var.fn_min_instance_count
    available_memory                 = var.fn_available_memory
    timeout_seconds                  = var.fn_timeout_sec
    max_instance_request_concurrency = var.fn_concurrent_requests
    available_cpu                    = var.fn_available_cpu_str
    environment_variables = {
      PROTOCOL               = var.env_variable_protocol
      DOMAIN                 = var.domain_name
      API_PORT               = var.env_variables_api_port
      VERSION                = var.env_variables_api_version
      VERIFY_END_POINT       = var.env_variables_verify_end_point
      SET_VALIDITY_END_POINT = var.env_variables_set_validity_end_point
      VALIDITY_MINUTES       = var.env_variables_validity_minutes
      MAILCHIMP_API_KEY      = var.email_server_API_KEY
      DATABASE_USER          = google_sql_user.user.name
      DATABASE_PASSWORD      = google_sql_user.user.password
      DATABASE_IP            = google_sql_database_instance.instance.private_ip_address
      DB_PORT                = var.db_port
      DB_NAME                = google_sql_database.database.name
      MAILGUN_API_KEY        = var.mail_gun_api_key
      SENDER_FULL_NAME       = var.sender_full_name
      SENDER_EMAIL           = "${var.sender_email_user_name}@${var.domain_name}"
      EMAIL_SUBJECT          = var.email_subject

    }
    vpc_connector                 = google_vpc_access_connector.connector.self_link
    vpc_connector_egress_settings = var.vpc_connector_egress_settings

    ingress_settings               = var.service_ingress_setting
    all_traffic_on_latest_revision = true
  }

  event_trigger {
    trigger_region        = var.region
    event_type            = var.event_type
    pubsub_topic          = google_pubsub_topic.user-created.id
    service_account_email = google_service_account.pub_sub_service_account.email
    retry_policy          = var.event_trigger_retry_policy
  }
}
