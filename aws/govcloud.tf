/*
  This is a stepping stone to reuse existing knowledge on paving AWS
  and applying it to GovCloud with as few changes as possible.
  This is an opt-in change and fully backward compatible out-of-the-box.

  Given the strict requirements associated to any AWS GovCloud, it is
  unfeasible for us to provide any kind of support for GovCloud.

  DISCLAIMER:

  This opt-in functionality is provided AS-IS. We make no warranties,
  express or implied, and hereby disclaims all implied warranties,
  including any warranty of merchantability and warranty of fitness
  for a particular purpose.
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
