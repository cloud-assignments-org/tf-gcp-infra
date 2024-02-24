# Add firewall rules to allow traffic to your application's port and deny SSH access from the internet.

resource "google_compute_firewall" "allow_app_traffic" {
  name    = "${var.vpc_name}-allow-app-traffic"
  network = google_compute_network.vpc.self_link

  allow {
    protocol = var.application_protocol
    ports    = var.application_ports
  }
  direction = "INGRESS"
  source_ranges = var.source_ranges_internet
  target_tags = var.allow_internet
}

resource "google_compute_firewall" "deny_ssh" {
  name    = "${var.vpc_name}-deny-ssh"
  network = google_compute_network.vpc.self_link
  direction = "INGRESS"
  deny {
    protocol = var.ssh_protocol
    ports    = var.ssh_ports
  }

  source_ranges = var.source_ranges_internet
}
