# Reference article https://cloud.google.com/sql/docs/mysql/configure-private-services-access#create_a_private_connection

# TODO: Add variables before committing this file


# Allocate an IP address range
resource "google_compute_global_address" "private_ip_address" {
  name          = var.private_service_name
  purpose       = var.private_service_purpose
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.vpc.self_link
}

# Create a private connection
resource "google_service_networking_connection" "default" {
  network                 = google_compute_network.vpc.self_link
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}
