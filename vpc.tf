resource "google_compute_network" "vpc" {
  name                            = var.vpc_name
  auto_create_subnetworks         = var.auto_create_subnets
  delete_default_routes_on_create = var.delete_default_routes
  routing_mode                    = var.routing_mode
  description                     = var.vpc_description
}
