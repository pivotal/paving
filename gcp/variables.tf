variable "project" {
  type = string
}

variable "environment_name" {
  type = string
}

variable "region" {
  type = string
}

variable "service_account_key" {
  type = string
}

variable "hosted_zone" {
  description = "Hosted zone name (e.g. foo is the zone name and foo.example.com is the DNS name)."
}

variable "availability_zones" {
  description = "Requires exactly THREE availability zones that must belong to the provided region."
  type        = list
}

variable "ssl_certificate" {
  description = "The contents of an SSL certificate to be used by the LB."
}

variable "ssl_private_key" {
  description = "The contents of an SSL private key to be used by the LB."
}
