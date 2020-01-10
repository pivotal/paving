variable "subscription_id" {
  type = string
}

variable "client_id" {
  type = string
}

variable "client_secret" {
  type = string
}

variable "tenant_id" {
  type = string
}

variable "environment_name" {
  type = string
}

variable "location" {
  type = string
}

variable "hosted_zone" {
  description = "Hosted zone name (e.g. foo.example.com)"
  type = string
}

variable "cloud_name" {
  description = "The Azure cloud environment to use. Available values at https://www.terraform.io/docs/providers/azurerm/#environment"
  default     = "public"
  type = string
}
