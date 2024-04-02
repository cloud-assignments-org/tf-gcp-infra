/*
https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_region_autoscaler
Represents an Autoscaler resource.

Autoscalers allow you to automatically scale 
virtual machine instances in managed instance groups 
according to an autoscaling policy that you define.
*/

resource "google_compute_region_autoscaler" "webapp" {
  name   = "webapp-autoscaler"
  region = var.region
  target = google_compute_region_instance_group_manager.webapp.id

  autoscaling_policy {
    max_replicas    = 6
    min_replicas    = 1
    cooldown_period = 25
    mode            = "ON"

    cpu_utilization {
      target = 0.25
    }
  }
}
