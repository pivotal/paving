terraform {
  required_providers {
    nsxt = {
      source = "terraform-providers/nsxt"
    }
    tls = {
      source = "hashicorp/tls"
    }
  }
  required_version = ">= 0.13"
}
