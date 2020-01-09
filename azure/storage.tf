resource "random_string" "ops-manager" {
  length  = 10
  special = false
  upper   = false
}

resource "azurerm_storage_account" "ops-manager" {
  name                     = "${var.environment_name}-${random_string.ops-manager.result}"
  resource_group_name      = azurerm_resource_group.platform.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "random_string" "pas_storage_account_name" {
  length  = 10
  special = false
  upper   = false
}

resource "azurerm_storage_account" "pas" {
  name                     = "${var.environment_name}-${random_string.pas_storage_account_name.result}"
  resource_group_name      = azurerm_resource_group.platform.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "pas-buildpacks" {
  name                  = "${var.environment_name}-pas-buildpakcs"
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

