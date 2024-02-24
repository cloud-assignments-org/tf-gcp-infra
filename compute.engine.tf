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
    EOF
}
