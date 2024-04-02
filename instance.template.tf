resource "google_compute_region_instance_template" "webapp" {
  name = "webapp-template"

  # Here we bring in the same config as we have for our compute instance

  # Disks to attach to instances created from this template. 
  # This can be specified multiple times for multiple disks.
  disk {
    auto_delete  = true
    boot         = true
    device_name  = "persistent-disk-0"
    mode         = "READ_WRITE"
    source_image = "projects/${var.project_id}/global/images/${var.image_name}"
    type         = "PERSISTENT"
    # disk_type    = var.disk_type
    disk_size_gb = var.machine_size
  }
  machine_type = var.machine_type

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

  network_interface {
    network    = google_compute_network.vpc.self_link
    subnetwork = google_compute_subnetwork.webapp.self_link
    access_config {
      // Ephemeral public IP
    }
  }
  region = var.region
  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
    provisioning_model  = "STANDARD"
  }

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email = google_service_account.compute_instance_service_account.email
    # https://cloud.google.com/sdk/gcloud/reference/alpha/compute/instances/set-scopes#--scopes
    # We do  not restrict scopes here, rather we create roles for scopes to restrict access
    # This is similar to assigning roles to users through IAM
    scopes = var.compute_instance_service_acc_scopes
  }

  # this tag will ensure the firewall rules are applied to instances of this tempalte
  # No other tags are required here
  tags = ["load-balanced-backend"]
}
