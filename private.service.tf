# Reference article https://cloud.google.com/sql/docs/mysql/configure-private-services-access#create_a_private_connection


# Allocate an IP address range
resource "google_compute_global_address" "private_ip_address" {
  name          = var.private_service_name
  purpose       = var.private_service_purpose
  address_type  = var.private_service_address_type
  prefix_length = var.private_service_prefix_length
  network       = google_compute_network.vpc.self_link
}

# Create a private connection
resource "google_service_networking_connection" "default" {
  network                 = google_compute_network.vpc.self_link
  service                 = var.private_connection_service
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
  deletion_policy         = var.private_connection_service_deletion_policy
}
