terraform {
  required_providers 
    google = {
      source  = "hashicorp/google"
      version = "~> 3.5"
    }
  }
}

provider "google" {
  credentials = file(var.credentials_file_path)
  project     = var.project_id
  region      = var.region
}

resource "google_compute_network" "vpc" {
  name                    = var.vpc_name
  auto_create_subnetworks = var.auto_create_subnets
  routing_mode            = var.routing_mode
  description             = var.vpc_description
}

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

resource "google_compute_route" "zero_for_webapp" {
  name             = var.route_name
  dest_range       = var.destination_range
  network          = google_compute_network.vpc.self_link
  priority         = var.route_priority
  tags             = var.route_tags
  next_hop_gateway = var.next_hop_gateway
}
