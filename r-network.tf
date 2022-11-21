resource "azurerm_network_security_rule" "management_apim" {
  count                       = var.create_management_rule ? 1 : 0
  access                      = "Allow"
  direction                   = "Inbound"
  name                        = local.nsg_rule_name
  network_security_group_name = var.nsg_name
  priority                    = var.management_nsg_rule_priority
  protocol                    = "Tcp"
  resource_group_name         = var.nsg_rg_name == null ? var.resource_group_name : var.nsg_rg_name

  source_port_range          = "*"
  destination_port_range     = "3443"
  source_address_prefix      = "ApiManagement"
  destination_address_prefix = "VirtualNetwork"
}
