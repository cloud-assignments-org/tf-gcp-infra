variable "instance_group_manager_name" {
  type        = string
  description = "The name of the instance group manager"
}

variable "named_port_name" {
  type        = string
  description = "The name of the named port"
}

variable "base_instance_name" {
  type        = string
  description = "The base name for the instances created by the instance group manager"
}

variable "instance_group_manager_version_name" {
  type        = string
  description = "The name of the version in the instance group manager"
}
