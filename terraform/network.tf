# resource azurerm_virtual_network vnet {
#   address_space = [
#     "192.168.0.0/24"
#   ]
#   location = azurerm_resource_group.rg.location
#   name = "adb"
#   resource_group_name = azurerm_resource_group.rg.name
# }
#
# resource azurerm_subnet adb_public {
#   address_prefixes     = [
#     cidrsubnet(azurerm_virtual_network.vnet.address_space[0], 1, 0)
#   ]
#   name                 = "adb_public"
#   resource_group_name  = azurerm_resource_group.rg.name
#   virtual_network_name = azurerm_virtual_network.vnet.name
#
#
#
#   delegation {
#     name = "delegation"
#
#     service_delegation {
#       name    = "Microsoft.Databricks/workspaces"
#       actions = [
#         "Microsoft.Network/virtualNetworks/subnets/join/action",
#         "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
#         "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"      ]
#     }
#   }
# }
#
# resource azurerm_subnet adb_private {
#   address_prefixes     = [
#     cidrsubnet(azurerm_virtual_network.vnet.address_space[0], 1, 1)
#   ]
#   name                 = "adb_private"
#   resource_group_name  = azurerm_resource_group.rg.name
#   virtual_network_name = azurerm_virtual_network.vnet.name
#
#   delegation {
#     name = "delegation"
#
#     service_delegation {
#       name    = "Microsoft.Databricks/workspaces"
#       actions = [
#         "Microsoft.Network/virtualNetworks/subnets/join/action",
#         "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
#         "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"      ]
#     }
#   }
# }
#
# resource azurerm_network_security_group nsg {
#   location            = azurerm_resource_group.rg.location
#   name                = "nsg"
#   resource_group_name = azurerm_resource_group.rg.name
# }
#
# resource azurerm_subnet_network_security_group_association public_subnet_nsg_assoc {
#   network_security_group_id = azurerm_network_security_group.nsg.id
#   subnet_id                 = azurerm_subnet.adb_public.id
# }
#
# resource azurerm_subnet_network_security_group_association private_subnet_nsg_assoc {
#   network_security_group_id = azurerm_network_security_group.nsg.id
#   subnet_id                 = azurerm_subnet.adb_private.id
# }
