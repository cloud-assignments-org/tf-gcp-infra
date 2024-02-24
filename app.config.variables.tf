# Variables for the app config
variable "app_port" {
  description = "The port on which the application will run."
  type        = number
}

variable "db_type" {
  description = "The type of database."
  type        = string
}

variable "db_port" {
  description = "The port on which the database service is accessible."
  type        = number
}

variable "config_file_loc" {
  description = "The location on the VM where the app config resides."
  type        = string
}
