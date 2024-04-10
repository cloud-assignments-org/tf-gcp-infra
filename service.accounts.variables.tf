variable "compute_instance_service_acc_id" {
  type        = string
  description = "The account id that is used to generate the service account email address and a stable unique id. It is unique within a project, must be 6-30 characters long, and match the regular expression a-z to comply with RFC1035. Changing this forces a new service account to be created."
}


variable "compute_instance_service_acc_display_name" {
  type        = string
  description = "The display name for the service account. Can be updated without creating a new resource."
}

variable "compute_instance_service_acc_scopes" {
  type        = list(string)
  description = "(Required) A list of service scopes. Both OAuth2 URLs and gcloud short names are supported. To allow full access to all Cloud APIs, use the cloud-platform scope. "
}


variable "pub_sub_service_account_id" {
  type    = string
  default = "pub-sub-service-account"
}

variable "pub_sub_service_account_disp_name" {
  type    = string
  default = "Pub Sub Service Account"
}

variable "google_project_service_identity_service" {
  type = string
  default = "sqladmin.googleapis.com"
}
