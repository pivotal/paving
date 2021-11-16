terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "~>4.1.0"
    }
    random = {
      source = "hashicorp/random"
    }
    tls = {
      source = "hashicorp/tls"
    }
  }
  required_version = ">= 0.14"
}
