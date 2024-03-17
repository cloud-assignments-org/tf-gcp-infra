/**
https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_service_account
**/
resource "google_service_account" "ops_agent_service_account" {
  account_id   = var.ops_agent_service_acc_id
  display_name = var.ops_agent_service_acc_display_name
}
