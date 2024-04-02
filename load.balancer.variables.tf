# Webapp health check
variable "health_check_name" {
  type        = string
  description = "The name of the health check"
}

variable "health_check_interval_sec" {
  type        = number
  description = "How often (in seconds) to send a health check"
}

variable "health_check_healthy_threshold" {
  type        = number
  description = "Number of consecutive successful health checks required for the instance to be considered healthy"
}

variable "health_check_port_specification" {
  type        = string
  description = "Specifies how to determine which port to use for the health check"
}

variable "health_check_request_path" {
  type        = string
  description = "The request path for the HTTP health check request"
}

variable "health_check_timeout_sec" {
  type        = number
  description = "How long (in seconds) to wait before claiming failure"
}

variable "health_check_unhealthy_threshold" {
  type        = number
  description = "Number of consecutive failed health checks required to consider the instance unhealthy"
}

#  BACKEND SERVICE VARIABLES

variable "backend_service_name" {
  type        = string
  description = "The name of the backend service"
}

variable "backend_service_load_balancing_scheme" {
  type        = string
  description = "The load balancing scheme of the backend service"
}

variable "backend_service_protocol" {
  type        = string
  description = "The protocol used by the backend service"
}

variable "backend_service_session_affinity" {
  type        = string
  description = "The session affinity type used by the backend service"
}

variable "backend_service_timeout_sec" {
  type        = number
  description = "The timeout period (in seconds) used by the backend service"
}

variable "backend_balancing_mode" {
  type        = string
  description = "The balancing mode for the backend"
}

variable "backend_capacity_scaler" {
  type        = number
  description = "The capacity scaler value of the backend"
}

# URL MAP
variable "url_map_name" {
  type        = string
  description = "The name of the URL map"
  default = "webapp-url-map"
}

# SSL Certificate
variable "ssl_certificate_name" {
  type        = string
  description = "The name of the SSL certificate"
  default = "webapp-ssl-cert"
}

# Target HTTPS Proxy 
variable "https_proxy_name" {
  type        = string
  description = "The name of target HTTPS proxy"
  default = "webapp-target-htttp-proxy"
}
