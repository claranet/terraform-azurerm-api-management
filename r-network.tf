resource "azurerm_network_security_rule" "management_apim" {
  access                      = "Allow"
  direction                   = "Inbound"
  name                        = "allow_apim_management"
  network_security_group_name = var.nsg_name
  priority                    = 101
  protocol                    = "Tcp"
  resource_group_name         = var.nsg_rg_name == null ? var.resource_group_name : var.nsg_rg_name

  source_port_range          = "*"
  destination_port_range     = "3443"
  source_address_prefix      = "ApiManagement"
  destination_address_prefix = "VirtualNetwork"
}

