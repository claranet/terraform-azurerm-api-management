data "azurecaf_name" "apim" {
  name          = var.stack
  resource_type = "azurerm_api_management"
  prefixes      = var.name_prefix == "" ? null : [local.name_prefix]
  suffixes      = compact([var.client_name, var.location_short, var.environment, local.name_suffix, var.use_caf_naming ? "" : "apim"])
  use_slug      = var.use_caf_naming
  clean_input   = true
  separator     = "-"
}

data "azurecaf_name" "apim_nsg_rule" {
  name          = var.stack
  resource_type = "azurerm_network_security_rule"
  prefixes      = var.name_prefix == "" ? null : [local.name_prefix]
  suffixes      = compact([var.client_name, var.location_short, var.environment, local.name_suffix, var.use_caf_naming ? "" : "apim-nsg"])
  use_slug      = var.use_caf_naming
  clean_input   = true
  separator     = "-"
}
