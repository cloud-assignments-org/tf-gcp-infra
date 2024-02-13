variable "project_id" {
  description = "The Project ID for the Google Cloud resources"
  type        = string
}

variable "region" {
  description = "The Google Cloud region where resources will be created"
  type        = string
}

variable "vpc_name" {
  description = "Name of the VPC to be created"
  type        = string
}

variable "vpc_description" {
  description = "Description of the VPC"
  type        = string
}

variable "webapp_subnet_cidr" {
  description = "CIDR block for the webapp subnet"
  type        = string
}

variable "db_subnet_cidr" {
  description = "CIDR block for the db subnet"
  type        = string
}

variable "webapp_subnet_name" {
  description = "Name for the webapp subnet"
  type        = string
}

variable "db_subnet_name" {
  description = "Name for the db subnet"
  type        = string
}

variable "route_name" {
  description = "Name for the route to be created"
  type        = string
}

variable "route_tags" {
  description = "Tags for the instances to which the route will apply"
  type        = list(string)
}

variable "credentials_file_path" {
  description = "Path to the Google Cloud service account credentials JSON file"
  type        = string
}
