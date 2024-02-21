resource "google_compute_instance" "app_instance" {
  name         = var.instance_name
  machine_type = var.machine_type
  zone         = var.zone

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
  }

  service_account {
    scopes = var.service_account_scopes
  }
}
