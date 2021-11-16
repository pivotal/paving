resource "random_string" "pas" {
  length  = 20
  special = false
  upper   = false
}

resource "azurerm_storage_account" "pas" {
  name                      = random_string.pas.result
  resource_group_name       = azurerm_resource_group.platform.name
  location                  = var.location
  account_tier              = "Standard"
  account_kind              = "StorageV2"
  account_replication_type  = "LRS"
  enable_https_traffic_only = true

  tags = merge(
  var.tags,
  {
    environment = var.environment_name
    name        = random_string.pas.result
  },
  )
}

resource "azurerm_advanced_threat_protection" "pas" {
  target_resource_id = azurerm_storage_account.pas.id
  enabled            = false

  depends_on = [
    azurerm_storage_account.pas
  ]
}

resource "azurerm_storage_container" "pas-buildpacks" {
  name                  = "${var.environment_name}-pas-buildpacks"
  storage_account_name  = azurerm_storage_account.pas.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "pas-packages" {
  name                  = "${var.environment_name}-pas-packages"
  storage_account_name  = azurerm_storage_account.pas.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "pas-droplets" {
  name                  = "${var.environment_name}-pas-droplets"
  storage_account_name  = azurerm_storage_account.pas.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "pas-resources" {
  name                  = "${var.environment_name}-pas-resources"
  storage_account_name  = azurerm_storage_account.pas.name
  container_access_type = "private"
}
