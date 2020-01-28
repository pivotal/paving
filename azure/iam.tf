resource "azurerm_role_definition" "pks-master" {
  name        = "${var.environment_name}-pks-master-role"
  scope       = "/subscriptions/${var.subscription_id}"
  description = "This is a custom role created via Terraform"

  permissions {
    actions = [
      "Microsoft.Network/*",
      "Microsoft.Compute/disks/*",
      "Microsoft.Compute/virtualMachines/write",
      "Microsoft.Compute/virtualMachines/read",
      "Microsoft.Storage/storageAccounts/*",
    ]
    not_actions = []
  }

  assignable_scopes = [
    "/subscriptions/${var.subscription_id}/resourceGroups/${var.environment_name}",
  ]
}

resource "azurerm_role_definition" "pks-worker" {
  name        = "${var.environment_name}-pks-worker-role"
  scope       = "/subscriptions/${var.subscription_id}"
  description = "This is a custom role created via Terraform"

  permissions {
    actions = [
      "Microsoft.Storage/storageAccounts/*",
    ]
    not_actions = []
  }

  assignable_scopes = [
    "/subscriptions/${var.subscription_id}/resourceGroups/${var.environment_name}"
  ]
}

resource "azurerm_user_assigned_identity" "pks-master" {
  name                = "${var.environment_name}-pks-master"
  resource_group_name = azurerm_resource_group.platform.name
  location            = var.location

  tags = merge(
    var.tags,
    { name = "${var.environment_name}-pks-master" },
  )
}

resource "azurerm_role_assignment" "pks-master" {
  scope              = "/subscriptions/${var.subscription_id}/resourceGroups/${var.environment_name}"
  role_definition_id = azurerm_role_definition.pks-master.id
  principal_id       = azurerm_user_assigned_identity.pks-master.principal_id
}

resource "azurerm_user_assigned_identity" "pks-worker" {
  name                = "${var.environment_name}-pks-worker"
  resource_group_name = azurerm_resource_group.platform.name
  location            = var.location

  tags = merge(
    var.tags,
    { name = "${var.environment_name}-pks-worker" },
  )
}

resource "azurerm_role_assignment" "pks-worker" {
  scope              = "/subscriptions/${var.subscription_id}/resourceGroups/${var.environment_name}"
  role_definition_id = azurerm_role_definition.pks-worker.id
  principal_id       = azurerm_user_assigned_identity.pks-worker.principal_id
}
