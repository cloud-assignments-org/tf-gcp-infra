variable "deletion_protection" {
  description = "Protects the CloudSQL instance from being deleted."
  type        = bool
  default     = false
}

variable "availability_type" {
  description = "The availability type of the CloudSQL instance."
  type        = string
  default     = "REGIONAL"
}

variable "db_disk_type" {
  description = "The type of disk for the CloudSQL instance."
  type        = string
  default     = "PD_SSD"
}

variable "db_disk_size" {
  description = "The size of the disk for the CloudSQL instance, in GB."
  type        = number
  default     = 100
}

variable "ipv4_enabled" {
  description = "Enables IPv4 connectivity for the CloudSQL instance."
  type        = bool
  default     = false
}

variable "database_version" {
  description = "The version of the database for the CloudSQL instance."
  type        = string
}

variable "tier" {
  description = "The tier of the CloudSQL instance, which determines its performance characteristics."
  type        = string
}


variable "password_length" {
  description = "The length of the generated password."
  type        = number
}

variable "password_special" {
  description = "Determines if special characters are allowed in the generated password."
  type        = bool
}

variable "password_override_special" {
  description = "A string of special characters that will be used in the generated password if special characters are enabled."
  type        = string
}

variable "db_resource_name" {
  description = "The name of the resource."
  type        = string
  // You can provide a default name, or leave it without a default to require it to be specified.
  default = "webapp"
}


variable "google_secret_manager_secret_DB_HOST_SECRET_ID" {
  type = string
}

variable "google_secret_manager_secret_DB_PASSWD_SECRET_ID" {
  type = string
}
