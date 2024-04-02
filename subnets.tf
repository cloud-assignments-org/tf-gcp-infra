resource "google_compute_subnetwork" "webapp" {
  name          = var.webapp_subnet_name
  ip_cidr_range = var.webapp_subnet_cidr
  network       = google_compute_network.vpc.self_link
  region        = var.region
}

resource "google_compute_subnetwork" "db" {
  name          = var.db_subnet_name
  ip_cidr_range = var.db_subnet_cidr
  network       = google_compute_network.vpc.self_link
  region        = var.region
}

# Subnet for the load balancer's proxies
resource "google_compute_subnetwork" "lb_proxy_only" {
  name          = var.subnetwork_name
  ip_cidr_range = var.subnetwork_ip_cidr_range
  network       = google_compute_network.vpc.id
  purpose       = var.subnetwork_purpose
  region        = var.region
  role          = var.subnetwork_role
}

