resource "google_vpc_access_connector" "connector" {
  name          = "vpc-con"
  ip_cidr_range = "10.0.2.0/28"
  network       = google_compute_network.vpc.self_link
}
