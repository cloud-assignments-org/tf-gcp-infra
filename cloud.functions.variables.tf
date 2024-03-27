# Function Source
variable "cloud_fn_source_name" {
  type = string
}

variable "cloud_fn_source_bucket" {
  type = string
}

# Function Name
variable "cloud_fn_random_suffix_len" {
  type = number
}

variable "cloud_fn_random_suffix_spl" {
  type = bool
}

variable "cloud_fn_random_suffix_ovRide_special" {
  type = string
}

# Function Definition
variable "trigger_user_verification_email_fn_prefix" {
  type = string
}

variable "trigger_user_verification_email_fn_description" {
  type = string
}

variable "build_config_runtime" {
  type = string
}

variable "build_config_entrypoint" {
  type = string
}

# Function service config
variable "fn_max_instance_count" {
  type = number
}

variable "fn_min_instance_count" {
  type = number
}

variable "fn_available_memory" {
  type = string
}

variable "fn_timeout_sec" {
  type = number
}

variable "fn_concurrent_requests" {
  type = number
}

variable "fn_available_cpu_str" {
  type = string
}

# Environment Variables

variable "env_variable_protocol" {
  type = string
}

variable "env_variable_domain" {
  type = string
}

variable "env_variables_api_port" {
  type = string
}


variable "env_variables_api_version" {
  type = string
}

variable "env_variables_verify_end_point" {
  type = string
}

variable "env_variables_set_validity_end_point" {
  type = string
}

variable "env_variables_validity_minutes" {
  type = string
}

variable "email_server_API_KEY" {
  type = string
}

# Function triggers ingress and egress 

variable "vpc_connector_egress_settings" {
  type = string
}

variable "service_ingress_setting" {
  type = string
}

# Event trigger 
variable "event_type" {
  type = string
}

variable "event_trigger_retry_policy" {
  type        = string
  description = "Describes the retry policy in case of function's execution failure. Retried execution is charged as any other execution. Possible values: ['RETRY_POLICY_UNSPECIFIED', 'RETRY_POLICY_DO_NOT_RETRY', 'RETRY_POLICY_RETRY']"
}
