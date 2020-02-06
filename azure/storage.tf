resource "random_string" "ops-manager" {
  length  = 20
  special = false
  upper   = false
}

resource "azurerm_storage_account" "ops-manager" {
  name                      = random_string.ops-manager.result
  resource_group_name       = azurerm_resource_group.platform.name
  location                  = var.location
  account_tier              = "Standard"
  account_kind              = "StorageV2"
  account_replication_type  = "LRS"
  enable_https_traffic_only = true

  enable_advanced_threat_protection = false

  tags = merge(
    var.tags,
    {
      environment = var.environment_name
      name        = random_string.ops-manager.result
    },
  )
}

resource "azurerm_storage_container" "ops-manager" {
  name                  = "opsmanagerimage"
  storage_account_name  = azurerm_storage_account.ops-manager.name
  container_access_type = "private"
}

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

  enable_advanced_threat_protection = false

  tags = merge(
    var.tags,
    {
      environment = var.environment_name
      name        = random_string.pas.result
    },
  )
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

resource random_string "bosh" {
  length  = 20
  special = false
  upper   = false
}

resource "azurerm_storage_account" "bosh" {
  name                      = random_string.bosh.result
  location                  = var.location
  account_tier              = "Standard"
  account_replication_type  = "LRS"
  account_kind              = "StorageV2"
  resource_group_name       = azurerm_resource_group.platform.name
  enable_https_traffic_only = true

  enable_advanced_threat_protection = false

  tags = merge(
    var.tags,
    {
      environment = var.environment_name
      account_for = "bosh"
      name        = random_string.bosh.result
    },
  )

  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_storage_container" "bosh" {
  name                  = "bosh"
  depends_on            = [azurerm_storage_account.bosh]
  storage_account_name  = azurerm_storage_account.bosh.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "stemcell" {
  name                  = "stemcell"
  depends_on            = [azurerm_storage_account.bosh]
  storage_account_name  = azurerm_storage_account.bosh.name
  container_access_type = "blob"
}

resource "azurerm_storage_table" "stemcells" {
  name                 = "stemcells"
  storage_account_name = azurerm_storage_account.bosh.name
}
