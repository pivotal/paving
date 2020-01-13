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