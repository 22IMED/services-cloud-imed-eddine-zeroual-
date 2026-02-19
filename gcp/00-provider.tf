terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 7.0"
    }
  }
}

provider "google" {
  project     = "playground-s-11-44b86b1e"
  region      = "europe-west1"
  zone        = "europe-west1-b"
  credentials = file("credentials.json")
}