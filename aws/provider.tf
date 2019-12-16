provider "aws" {
  version    = "~> 2.0"
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

terraform {
  required_version = ">= 0.12.0"
}

