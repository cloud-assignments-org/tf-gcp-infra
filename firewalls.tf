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

/** ALLOW HEALTH CHECK ==========================
An ingress rule, applicable to the instances being load balanced, 
that allows all TCP traffic from the Google Cloud health checking systems 
(in 130.211.0.0/22 and 35.191.0.0/16). 
This example uses the target tag load-balanced-backend to identify the 
VMs that the firewall rule applies to.
**/
resource "google_compute_firewall" "health_check" {
  name = var.health_check_firewall_name
  allow {
    ports    = [var.app_port]
    protocol = var.health_check_firewall_protocol
  }
  direction     = var.health_check_firewall_direction
  network       = google_compute_network.vpc.id
  priority      = var.health_check_firewall_priority
  source_ranges = var.health_check_firewall_source_ranges
  target_tags   = var.health_check_firewall_target_tags
}



/** ALLOW LOAD BALANCER PROXY =============================
An ingress rule, applicable to the instances being load balanced, 
that allows TCP traffic on ports 80, 443, and 8080 from the 
regional external Application Load Balancer's managed proxies. 

Uses tag to identify the VMs that the firewall rule applies to.

Without these firewall rules, the default deny ingress rule blocks 
incoming traffic to the backend instances.

The target tags define the backend instances. 
Without the target tags, the firewall rules apply to all of 
your backend instances in the VPC network. 
When you create the backend VMs, make sure to include 
the specified target tags, as shown in Creating a managed instance group.
**/

resource "google_compute_firewall" "allow_load_balancer_proxy" {
  name        = var.allow_lb_proxy_name
  allow {
    ports    = [var.app_port]
    protocol = var.allow_lb_proxy_protocol
  }
  direction     = var.allow_lb_proxy_direction
  network       = google_compute_network.vpc.id
  priority      = var.allow_lb_proxy_priority
  source_ranges = var.allow_lb_proxy_source_ranges
  target_tags   = var.allow_lb_proxy_target_tags
}
