variable "access_key" {
  type = string
}

variable "secret_key" {
  type = string
}

variable "environment_name" {
  type = string
}

variable "region" {
  type = string
}

variable "hosted_zone" {
  description = "Hosted zone name (e.g. foo.example.com)"
  type        = string
}

variable "availability_zones" {
  description = "The list of availability zones to use. Must belong to the provided region and equal the number of CIDRs provided for each subnet."
  type        = list
}

variable "ssl_certificate" {
  default = ""
  type    = string
}

variable "ssl_private_key" {
  default = ""
  type    = string
}

variable "public_subnet_cidrs" {
  default     = ["10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24"]
  description = "The list of CIDRs for the Public subnet. Number of CIDRs MUST match the number of AZs."
  type        = list
}

variable "management_subnet_cidrs" {
  default     = ["10.0.16.0/24", "10.0.17.0/24", "10.0.18.0/24"]
  description = "The list of CIDRs for the Management subnet. Number of CIDRs MUST match the number of AZs."
  type        = list
}

variable "pas_subnet_cidrs" {
  default     = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  description = "The list of CIDRs for the PAS subnet. Number of CIDRs MUST match the number of AZs."
  type        = list
}

variable "pks_subnet_cidrs" {
  default     = ["10.0.12.0/24", "10.0.13.0/24", "10.0.14.0/24"]
  description = "The list of CIDRs for the PKS subnet. Number of CIDRs MUST match the number of AZs."
  type        = list
}

variable "services_subnet_cidrs" {
  default     = ["10.0.8.0/24", "10.0.9.0/24", "10.0.10.0/24"]
  description = "The list of CIDRs for the Services subnet. Number of CIDRs MUST match the number of AZs."
  type        = list
}

variable "ops_manager_allowed_ips" {
  description = "IPs allowed to communicate with Ops Manager."
  default     = ["0.0.0.0/0"]
  type        = list
}

variable "tags" {
  description = "Key/value tags to assign to all resources."
  default     = {}
  type        = map(string)
}
