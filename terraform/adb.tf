resource azurerm_databricks_workspace adb {
 name                = var.env
 resource_group_name = azurerm_resource_group.rg.name
 location            = azurerm_resource_group.rg.location
 sku                 = "premium"
}

