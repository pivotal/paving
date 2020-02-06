provider "azurerm" {
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
  environment     = var.cloud_name

  # Pinned to 1.33.0 due to this bug: https://github.com/terraform-providers/terraform-provider-azurerm/issues/3780
  version = "= 1.33.0"
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