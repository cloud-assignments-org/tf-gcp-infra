resource "google_compute_instance" "app_instance" {
  name         = var.instance_name
  machine_type = var.machine_type
  zone         = var.zone
  tags         = var.allow_internet
  boot_disk {
    initialize_params {
      image = "projects/${var.project_id}/global/images/${var.image_name}"
      type  = var.disk_type
      size  = var.machine_size
    }
  }

  network_interface {
    network    = google_compute_network.vpc.self_link
    subnetwork = google_compute_subnetwork.webapp.self_link
    access_config {
      // Ephemeral public IP
    }
  }

  allow_stopping_for_update = var.allow_app_instance_stopping_for_update

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email = google_service_account.compute_instance_service_account.email
    # https://cloud.google.com/sdk/gcloud/reference/alpha/compute/instances/set-scopes#--scopes
    # We do  not restrict scopes here, rather we create roles for scopes to restrict access
    # This is similar to assigning roles to users through IAM
    scopes = var.compute_instance_service_acc_scopes
  }

  metadata_startup_script = <<-EOF
    #!/bin/bash
    touch ${var.config_file_loc}
    : > ${var.config_file_loc}
    cat > ${var.config_file_loc} <<-INNER_EOF
    PORT="${var.app_port}"
    # DATABASE
    DB_TYPE="${var.db_type}"
    DB_HOST="${google_sql_database_instance.instance.private_ip_address}"
    DB_PORT=${var.db_port}
    DB_USERNAME="${google_sql_user.user.name}"
    DB_PASSWORD="${google_sql_user.user.password}"
    DB_NAME="${google_sql_database.database.name}" 
    # Pub/Sub
    USER_CREATED_TOPC="${var.pub_sub_topic_name}"
    EMAIL_VALIDITY_MINUTES="${var.env_variables_validity_minutes}"
    EOF
}

output "instance_public_ip" {
  value = google_compute_instance.app_instance.network_interface.0.access_config.0.nat_ip
}

output "pub_sub_topic_name" {
  value = var.pub_sub_topic_name
}
