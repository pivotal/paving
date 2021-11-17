terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "~> 4.1"
    }
    random = {
      source = "hashicorp/random"
    }
    tls = {
      source = "hashicorp/tls"
    }
  }
  required_version = "~> 1.0"
}
