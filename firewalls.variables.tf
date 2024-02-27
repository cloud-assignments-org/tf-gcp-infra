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

variable "all_ports" {
  type = list(string)
  description = "Mention all ports"
  default = [ "all" ]
}

variable "source_ranges_internet" {
  type        = list(string)
  description = "CIDR source range for requests coming in from the internet"
  default = [ "0.0.0.0/0" ]
}

variable "allow_internet" {
  type        = list(string)
  description = "List of tags that will be associated with firewall that allows access from the internet"
}

variable "direction_ingress" {
  type        = string
  description = "For firewalls incoming rules"
  default = "INGRESS"
}

variable "allow_app_traffic_priority" {
  type = number
  description = "This gives the priority value to this firewall rule"
}

variable "deny_ssh_priority" {
  type = number
  description = "This gives the priority value to this firewall rule"
}

variable "deny_all_priority" {
  type = number
  description = "This gives the priority value to this firewall rule"
}

variable "tcp_protocol" {
  type = string
  description = "Refers to the tcp protocol"
  default = "tcp"
}

variable "udp_protocol" {
  type = string
  description = "Refers to the udp protocol"
  default = "udp"
}
