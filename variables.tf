variable "project_id" {
  description = "The Project ID for the Google Cloud resources"
  type        = string
}

variable "region" {
  description = "The Google Cloud region where resources will be created"
  type        = string
}

variable "zone" {
  description = "The Google Cloud zone where resources will be created"
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

variable "auto_create_subnets" {
  type = bool
  description = "When set to 'true', the network is created in `auto subnet mode and it will create a subnet for each region automatically across the '10.128.0.0/9' address range. When set to 'false', the network is created in `custom subnet mode` so the user can explicitly connect subnetwork resources."
}

variable "route_name" {
  description = "Name for the route to be created"
  type        = string
}

variable "route_tags" {
  description = "Tags for the instances to which the route will apply"
  type        = list(string)
}

variable "routing_mode" {
  type = string
  description = "The network-wide routing mode to use. If set to 'REGIONAL', this network's cloud routers will only advertise routes with subnetworks of this network in the same region as the router. If set to 'GLOBAL', this network's cloud routers will advertise routes with all subnetworks of this network, across regions. Possible values: [\"REGIONAL\", \"GLOBAL\"]"
}

variable "route_priority" {
  type = number
  description = "The priority of this route. Priority is used to break ties in cases where there is more than one matching route of equal prefix length. In the case of two routes with equal prefix length, the one with the lowest-numbered priority value wins. Default value is 1000. Valid range is 0 through 65535."
}

variable "next_hop_gateway" {
  description = "URL to a gateway that should handle matching packets."
  type = string
}

variable "destination_range" {
  description = "The destination range of outgoing packets that this route applies to. Only IPv4 is supported."
  type = string
}

variable "credentials_file_path" {
  description = "Path to the Google Cloud service account credentials JSON file"
  type        = string
}

variable "image_name" {
  description = "Name of the custom image that needs to be used to start a VM instance"
  type        = string
}
