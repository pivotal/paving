terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~> 1.43"
    }
    random = {
      source = "hashicorp/random"
    }
    tls = {
      source = "hashicorp/tls"
    }
  }
  required_version = ">= 0.14"
}
