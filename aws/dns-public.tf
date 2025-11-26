/*
  This is a stepping stone to allow configuring AWS with a private-public
  DNS architecture: https://docs.aws.amazon.com/managedservices/latest/userguide/set-dns.html
  This is an opt-in change and fully backward compatible out-of-the-box.

  This adds an additional layer of security, and also allows you to fail over from a primary resource
  to a secondary one (often called a "flip") by mapping the DNS name to a different IP address.
*/

variable "public_dns_access_key" {
  type = string
  default = ""
}

variable "public_dns_secret_key" {
  type = string
  default = ""
}

variable "public_dns_region" {
  type = string
  default = ""
}

locals {
  public_dns_access_key = var.public_dns_access_key != "" ? var.public_dns_access_key : var.access_key
  public_dns_secret_key = var.public_dns_secret_key != "" ? var.public_dns_secret_key : var.secret_key
  public_dns_region = var.public_dns_region != "" ? var.public_dns_region : var.region
}

provider "aws" {
  alias      = "public-dns"
  region     = local.public_dns_region
  access_key = local.public_dns_access_key
  secret_key = local.public_dns_secret_key
}
