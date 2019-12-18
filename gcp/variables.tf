variable "project" {}
variable "environment_name" {}
variable "region" {}
variable "service_account_key" {}

variable "availability_zones" {
  description = "Requires exactly two availability zones that must belong to the provided region."
  type        = list
}

variable "ssl_certificate" {
  default = ""
}
