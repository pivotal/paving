provider "nsxt" {
  username             = var.nsxt_username
  password             = var.nsxt_password
  host                 = var.nsxt_host
  allow_unverified_ssl = var.allow_unverified_ssl
  version = "~> 1.1"
}
