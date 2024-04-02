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
  type        = list(string)
  description = "Mention all ports"
  default     = ["all"]
}

variable "source_ranges_internet" {
  type        = list(string)
  description = "CIDR source range for requests coming in from the internet"
  default     = ["0.0.0.0/0"]
}

variable "allow_internet" {
  type        = list(string)
  description = "List of tags that will be associated with firewall that allows access from the internet"
}

variable "direction_ingress" {
  type        = string
  description = "For firewalls incoming rules"
  default     = "INGRESS"
}

variable "allow_app_traffic_priority" {
  type        = number
  description = "This gives the priority value to this firewall rule"
}

variable "deny_ssh_priority" {
  type        = number
  description = "This gives the priority value to this firewall rule"
}

variable "deny_all_priority" {
  type        = number
  description = "This gives the priority value to this firewall rule"
}

variable "tcp_protocol" {
  type        = string
  description = "Refers to the tcp protocol"
  default     = "tcp"
}

variable "udp_protocol" {
  type        = string
  description = "Refers to the udp protocol"
  default     = "udp"
}

# HEALTH CHECK FIREWALL
variable "health_check_firewall_name" {
  type        = string
  description = "The name of the health check firewall"
}

variable "health_check_firewall_priority" {
  type        = number
  description = "The priority of the health check firewall rule"
}

variable "health_check_firewall_source_ranges" {
  type        = list(string)
  description = "The source IP ranges that are allowed to access the health check firewall"
  default     = ["130.211.0.0/22", "35.191.0.0/16"]
}

variable "health_check_firewall_target_tags" {
  type        = list(string)
  description = "A list of instance tags for the health check firewall, indicating the set of instances in the network that the firewall policy applies to"
}

variable "health_check_firewall_protocol" {
  type        = string
  description = "The protocol used by the health check firewall rule"
}

variable "health_check_firewall_direction" {
  type        = string
  description = "The direction of traffic to which the health check firewall rule applies"
}


# Load Balancer Proxy
variable "allow_lb_proxy_name" {
  type        = string
  description = "The name of the load balancer proxy firewall"
}

variable "allow_lb_proxy_priority" {
  type        = number
  description = "The priority of the load balancer proxy firewall rule"
  default     = 100
}

variable "allow_lb_proxy_source_ranges" {
  type        = list(string)
  description = "The source IP ranges that are allowed to access the load balancer proxy firewall"
}

variable "allow_lb_proxy_target_tags" {
  type        = list(string)
  description = "A list of instance tags for the load balancer proxy firewall, indicating the set of instances in the network that the firewall policy applies to"
}

variable "allow_lb_proxy_protocol" {
  type        = string
  description = "The protocol used by the load balancer proxy firewall rule"
}

variable "allow_lb_proxy_direction" {
  type        = string
  description = "The direction of traffic to which the load balancer proxy firewall rule applies"
  default     = "INGRESS"
}
