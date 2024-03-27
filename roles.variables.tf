variable "logging_admin_role" {
  type        = string
  description = "The role that has to be assigned"
}

variable "monitoring_metric_writer_role" {
  type        = string
  description = "The role that has to be assigned"
}

variable "pub_sub_publisher_role" {
  type        = string
  description = "The role that has to be assigned"
}

variable "service_acc_token_creator_role" {
  type        = string
  description = "The role that has to be assigned"
}

variable "cloud_functions_run_invoker_role" {
  type        = string
  description = "The role that has to be assigned"
}
