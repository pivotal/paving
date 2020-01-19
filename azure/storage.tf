resource "random_string" "ops-manager" {
  length  = 20
  special = false
  upper   = false
}

resource "azurerm_storage_account" "ops-manager" {
  name                     = random_string.ops-manager.result
  resource_group_name      = azurerm_resource_group.platform.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = var.environment_name
  }
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
  name                     = random_string.pas.result
  resource_group_name      = azurerm_resource_group.platform.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = var.environment_name
  }
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

resource random_string "bosh_storage_account_name" {
  length  = 20
  special = false
  upper   = false
}

resource "azurerm_storage_account" "bosh" {
  name                     = random_string.bosh_storage_account_name.result
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  resource_group_name      = azurerm_resource_group.platform.name

  tags = {
    environment = var.environment_name
    account_for = "bosh"
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_storage_container" "bosh_storage_container" {
  name                  = "bosh"
  depends_on            = [azurerm_storage_account.bosh]
  storage_account_name  = azurerm_storage_account.bosh.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "stemcell_storage_container" {
  name                  = "stemcell"
  depends_on            = [azurerm_storage_account.bosh]
  storage_account_name  = azurerm_storage_account.bosh.name
  container_access_type = "blob"
}

resource "azurerm_storage_table" "stemcells_storage_table" {
  name                 = "stemcells"
  storage_account_name = azurerm_storage_account.bosh.name
}
