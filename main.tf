terraform {
  required_version = "~> 0.12"

  required_providers {
    google = "~> 3.2"
  }
}

provider "google" {
  project = var.project
}
