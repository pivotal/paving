provider "azurerm" {
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret != "" ? var.client_secret : null
  tenant_id       = var.tenant_id
  environment     = var.cloud_name

  # Certificate authentication is supported via environment variables:
  # - ARM_CLIENT_CERTIFICATE_PATH: Path to PKCS#12 (.pfx) certificate file
  # - ARM_CLIENT_CERTIFICATE_PASSWORD: Certificate password (if encrypted)
  # See: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/service_principal_client_certificate

  features {}
}
