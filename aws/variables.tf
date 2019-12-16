variable "access_key" {}
variable "secret_key" {}
variable "environment_name" {}
variable "api_region" {}

variable "availability_zones" {
  description = "requires exactly two availability_zones"
  type = list
}
