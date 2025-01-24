locals {
  # Naming locals/constants
  name_prefix = lower(var.name_prefix)
  name_suffix = lower(var.name_suffix)

  name          = coalesce(var.custom_name, data.azurecaf_name.apim.result)
  nsg_rule_name = coalesce(var.management_rule_custom_name, data.azurecaf_name.apim_nsg_rule.result)
}
