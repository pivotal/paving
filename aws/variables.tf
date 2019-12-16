variable "access_key" {}
variable "secret_key" {}
variable "environment_name" {}
variable "region" {}

variable "availability_zones" {
  description = "Requires exactly two availability zones that must belong to the provided region."
  type        = list
}
