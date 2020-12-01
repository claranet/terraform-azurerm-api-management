resource "azurerm_api_management_named_value" "named_values" {
  for_each            = { for named_value in var.named_values : named_value["name"] => named_value }
  api_management_name = azurerm_api_management.apim.name
  display_name        = lookup(each.value, "display_name", lookup(each.value, "name"))
  name                = lookup(each.value, "name")
  resource_group_name = var.resource_group_name
  value               = lookup(each.value, "value")
  secret              = lookup(each.value, "secret", false)
}

