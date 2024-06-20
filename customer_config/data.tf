data azurerm_client_config current {}

data azurerm_subscription current {}

data azurerm_resource_group current {
  name     = "adb"
}

data azurerm_databricks_workspace adb {
  name = "databricks-${var.env}"
  resource_group_name = data.azurerm_resource_group.current.name
}