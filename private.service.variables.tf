
variable "private_service_name" {
  type        = string
  description = "The name of the private service"
}

variable "private_service_purpose" {
  type        = string
  description = "The purpose of the resource. Possible values include: VPC_PEERING - for peer networks, PRIVATE_SERVICE_CONNECT - for (Beta only) Private Service Connect networks"
}

variable "private_service_address_type" {
  type        = string
  description = "The type of the address to reserve: EXTERNAL indicates public/external single IP address., INTERNAL indicates internal IP ranges belonging to some network. Default value: \"EXTERNAL\" Possible values: [\"EXTERNAL\", \"INTERNAL\"]"
}

variable "private_service_prefix_length" {
  description = "The prefix length for the IP range of the private service."
  type        = number
  default     = 16
}
variable "private_connection_service" {
  description = "The service to connect via the private connection."
  type        = string
  default     = "servicenetworking.googleapis.com"
}


variable "private_connection_service_deletion_policy" {
  description = "The deletion policy to follow for the private connection service during teardown"
  type        = string
  default     = "ABANDON"
}
