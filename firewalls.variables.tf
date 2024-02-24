variable "application_protocol" {
  type        = string
  description = "Network protocol followed by the application"
}

variable "application_ports" {
  type        = list(string)
  description = "List of ports which the application runs"
}

variable "ssh_protocol" {
  type        = string
  description = "Networll protocol for ssh connections"
}

variable "ssh_ports" {
  type        = list(string)
  description = "List of ports where we are allowing ssh connection"
}

variable "source_ranges_internet" {
  type        = list(string)
  description = "CIDR source range for requests coming in from the internet"
}

variable "allow_internet" { 
  type = list(string)
  description = "List of tags that will be associated with firewall that allows access from the internet"
}
