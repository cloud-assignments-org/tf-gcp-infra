/*
https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_region_autoscaler
Represents an Autoscaler resource.

Autoscalers allow you to automatically scale 
virtual machine instances in managed instance groups 
according to an autoscaling policy that you define.
*/

resource "google_compute_region_autoscaler" "webapp" {
  name   = var.auto_scaler_name
  region = var.region
  target = google_compute_region_instance_group_manager.webapp.id

  autoscaling_policy {
    max_replicas    = var.auto_scaler_max_replicas
    min_replicas    = var.auto_scaler_min_replicas
    cooldown_period = var.auto_scaler_cooldown_period
    mode            = var.auto_scaler_mode
    
    cpu_utilization {
      target = var.auto_scaler_target_cpu_utilization
    }

    

    scale_in_control {
      max_scaled_in_replicas {
        percent = var.auto_scaler_scale_in_control_max_scaled_replica_percent
      }
      time_window_sec = var.auto_scaler_scale_in_control_time_window_sec
    }
  }
  

}
