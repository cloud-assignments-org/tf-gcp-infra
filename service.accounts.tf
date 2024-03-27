/**
https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_service_account
**/
# We need to create one single service account that has
# all the required roles for this instance
resource "google_service_account" "compute_instance_service_account" {
  account_id   = var.compute_instance_service_acc_id
  display_name = var.compute_instance_service_acc_display_name
}

resource "google_service_account" "pub_sub_service_account" {
  account_id   = "pub-sub-service-account"
  display_name = "Pub Sub Service Account"
}
