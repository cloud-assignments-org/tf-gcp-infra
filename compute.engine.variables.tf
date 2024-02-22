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
