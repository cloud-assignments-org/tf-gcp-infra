# Variables for the machine instance
variable "instance_name" {
  type        = string
  description = "The name of the instance. One of name or self_link must be provided."
}

variable "machine_type" {
  type        = string
  description = "The machine type to create"
}

variable "machine_size" {
  type        = number
  description = "The size of the image in gigabytes."
}

variable "disk_type" {
  type        = string
  description = "The Google Compute Engine disk type. One of pd-standard, pd-ssd or pd-balanced."
}

variable "allow_app_instance_stopping_for_update" {
  type        = bool
  description = "allows Terraform to stop the instance to update its properties. If you try to update a property that requires stopping the instance without setting this field, the update will fail."
}
