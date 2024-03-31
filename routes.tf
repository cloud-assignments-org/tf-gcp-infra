resource "google_compute_route" "zero_for_webapp" {
  name             = var.route_name
  dest_range       = var.destination_range
  network          = google_compute_network.vpc.self_link
  priority         = var.route_priority
  next_hop_gateway = var.next_hop_gateway
}
