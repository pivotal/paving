variable "access_key" {}
variable "secret_key" {}
variable "environment_name" {}
variable "region" {}

variable "dns_suffix" {}
variable "hosted_zone" {}

variable "availability_zones" {
  description = "Requires exactly two availability zones that must belong to the provided region."
  type        = list
}

variable "ops_manager_allowed_ips" {
  default     = ["0.0.0.0/0"]
  description = "IPs allowed to communicate with Ops Manager."
  type        = list
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Key/value tags to assign to all resources."
}
