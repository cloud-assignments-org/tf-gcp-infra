terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.17"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~> 5.24"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

provider "google-beta" {
  project = var.project_id
  region  = var.region
}
