# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_region_instance_group_manager

resource "google_compute_region_instance_group_manager" "webapp" {
  name   = var.instance_group_manager_name
  region = var.region

  named_port {
    name = var.named_port_name
    port = var.app_port
  }

  version {
    instance_template = google_compute_region_instance_template.webapp.id
    name              = var.instance_group_manager_version_name
  }

  depends_on = [google_compute_region_instance_template.webapp]

  base_instance_name = var.base_instance_name
}
