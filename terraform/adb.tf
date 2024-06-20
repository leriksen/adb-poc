#resource azurerm_databricks_workspace adb {
#  name                = "databricks-${var.env}"
#  resource_group_name = azurerm_resource_group.rg.name
#  location            = azurerm_resource_group.rg.location
#  sku                 = "premium"
#  custom_parameters {
#    public_subnet_name                                   = azurerm_subnet.adb_public.name
#    private_subnet_name                                  = azurerm_subnet.adb_private.name
#    virtual_network_id                                   = azurerm_virtual_network.vnet.id
#    public_subnet_network_security_group_association_id  = azurerm_subnet_network_security_group_association.public_subnet_nsg_assoc.id
#    private_subnet_network_security_group_association_id = azurerm_subnet_network_security_group_association.private_subnet_nsg_assoc.id
#  }
#}
#
