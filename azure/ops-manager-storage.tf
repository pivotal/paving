resource "random_string" "ops-manager" {
  length  = 20
  special = false
  upper   = false
}

resource "azurerm_storage_account" "ops-manager" {
  name                       = random_string.ops-manager.result
  resource_group_name        = azurerm_resource_group.platform.name
  location                   = var.location
  account_tier               = "Standard"
  account_kind               = "StorageV2"
  account_replication_type   = "LRS"
  https_traffic_only_enabled = true

  tags = merge(
    var.tags,
    {
      environment = var.environment_name
      name        = random_string.ops-manager.result
    },
  )
}

resource "azurerm_advanced_threat_protection" "ops-manager" {
  target_resource_id = azurerm_storage_account.ops-manager.id
  enabled            = false

  depends_on = [
    azurerm_storage_account.ops-manager
  ]
}


resource "azurerm_storage_container" "ops-manager" {
  name                  = "opsmanagerimage"
  storage_account_id    = azurerm_storage_account.ops-manager.id
  container_access_type = "private"
}

resource "random_string" "bosh" {
  length  = 20
  special = false
  upper   = false
}

resource "azurerm_storage_account" "bosh" {
  name                            = random_string.bosh.result
  location                        = var.location
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  account_kind                    = "StorageV2"
  resource_group_name             = azurerm_resource_group.platform.name
  https_traffic_only_enabled      = true
  allow_nested_items_to_be_public = true

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

resource "azurerm_advanced_threat_protection" "bosh" {
  target_resource_id = azurerm_storage_account.bosh.id
  enabled            = false
  depends_on = [
    azurerm_storage_account.bosh
  ]
}

resource "azurerm_storage_container" "bosh" {
  name                  = "bosh"
  depends_on            = [azurerm_storage_account.bosh]
  storage_account_id    = azurerm_storage_account.bosh.id
  container_access_type = "private"
}

resource "azurerm_storage_container" "stemcell" {
  name                  = "stemcell"
  depends_on            = [azurerm_storage_account.bosh]
  storage_account_id    = azurerm_storage_account.bosh.id
  container_access_type = "blob"
}

resource "azurerm_storage_table" "stemcells" {
  name                 = "stemcells"
  storage_account_name = azurerm_storage_account.bosh.name
}
