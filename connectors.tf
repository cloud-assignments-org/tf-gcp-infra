resource "google_vpc_access_connector" "connector" {
  name          = var.serverless_connector_name
  ip_cidr_range = var.serverless_connector_cidr
  network       = google_compute_network.vpc.self_link
}
