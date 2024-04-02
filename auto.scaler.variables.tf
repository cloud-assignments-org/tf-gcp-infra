variable "auto_scaler_name" {
  type        = string
  description = "The name of the autoscaler"
}

variable "auto_scaler_region" {
  type        = string
  description = "The region where the autoscaler is deployed"
}

variable "auto_scaler_max_replicas" {
  type        = number
  description = "The maximum number of instances for the autoscaler"
}

variable "auto_scaler_min_replicas" {
  type        = number
  description = "The minimum number of instances for the autoscaler"
}

variable "auto_scaler_cooldown_period" {
  type        = number
  description = "The amount of time, in seconds, that the autoscaler should wait before it starts collecting information from a new instance"
}

variable "auto_scaler_target_cpu_utilization" {
  type        = number
  description = "The target CPU utilization for the autoscaler"
}

variable "auto_scaler_mode" {
  type        = string
  description = "The operating mode for the autoscaler"
  default     = "ON"
}

variable "auto_scaler_scale_in_control_max_scaled_replica_percent" {
  type        = number
  description = "Specifies a percentage of instances between 0 to 100%, inclusive. For example, specify 80 for 80%."
}

variable "auto_scaler_scale_in_control_time_window_sec" {
  type        = number
  description = "How long back autoscaling should look when computing recommendations to include directives regarding slower scale down, as described above."
}
