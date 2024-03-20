# Add firewall rules to allow traffic to your application's port and deny SSH access from the internet.

resource "google_compute_firewall" "allow_app_traffic" {
  name     = "${var.vpc_name}-allow-app-traffic"
  network  = google_compute_network.vpc.self_link
  priority = var.allow_app_traffic_priority

  allow {
    protocol = var.application_protocol
    ports    = var.application_ports
  }
  direction     = var.direction_ingress
  source_ranges = var.source_ranges_internet
  target_tags   = var.allow_internet
}

resource "google_compute_firewall" "deny_ssh" {
  name      = "${var.vpc_name}-deny-ssh"
  network   = google_compute_network.vpc.self_link
  direction = var.direction_ingress
  priority  = var.deny_ssh_priority
  deny {
    protocol = var.ssh_protocol
    ports    = var.ssh_ports
  }

  source_ranges = var.source_ranges_internet
}

resource "google_compute_firewall" "deny_all_tcp" {
  name      = "${var.vpc_name}-deny-all-tcp"
  network   = google_compute_network.vpc.self_link
  direction = var.direction_ingress
  priority  = var.deny_all_priority
  deny {
    protocol = var.tcp_protocol
  }

  // currently 0.0.0.0/0 implies all IPv4 addresses
  source_ranges = var.source_ranges_internet
}

resource "google_compute_firewall" "deny_all_udp" {
  name      = "${var.vpc_name}-deny-all-udp"
  network   = google_compute_network.vpc.self_link
  direction = var.direction_ingress
  priority  = var.deny_all_priority
  deny {
    protocol = var.udp_protocol
  }

  // currently 0.0.0.0/0 implies all IPv4 addresses
  source_ranges = var.source_ranges_internet
}
