variable "ops_agent_service_acc_id" {
  type        = string
  description = "The account id that is used to generate the service account email address and a stable unique id. It is unique within a project, must be 6-30 characters long, and match the regular expression a-z to comply with RFC1035. Changing this forces a new service account to be created."
}


variable "ops_agent_service_acc_display_name" {
  type        = string
  description = "The display name for the service account. Can be updated without creating a new resource."
}
