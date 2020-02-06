provider "azurerm" {
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
  environment     = var.cloud_name

  version = "~> 1.43"
}

terraform {
  required_version = ">= 0.12.0"
}

provider random {
  version = "~> 2.2"
}

provider tls {
  version = "~> 2.1"
} 
