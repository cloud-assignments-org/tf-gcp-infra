# DISK
variable "webapp_disk_auto_delete" {
  type        = bool
  description = "Indicates whether the disk is auto-deleted when the instance is deleted"
}

variable "webapp_disk_boot" {
  type        = bool
  description = "Indicates whether the disk is a boot disk"
}

variable "webapp_disk_device_name" {
  type        = string
  description = "The name of the disk attached to the instance"
}

variable "webapp_disk_mode" {
  type        = string
  description = "The mode in which to attach this disk"
}

variable "webapp_disk_type" {
  type        = string
  description = "The type of the disk"
}


#Scheduling
variable "webapp_scheduling_automatic_restart" {
  type        = bool
  description = "Defines whether the instance should be automatically restarted in the event of a shutdown"
}

variable "webapp_scheduling_on_host_maintenance" {
  type        = string
  description = "Defines the instance's behavior when a maintenance event occurs that may cause instance downtime"
}

variable "webapp_scheduling_provisioning_model" {
  type        = string
  description = "Defines the provisioning model for the instance"
}

