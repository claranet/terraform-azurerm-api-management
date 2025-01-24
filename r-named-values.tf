resource "azurerm_api_management_named_value" "main" {
  for_each = { for named_value in var.named_values : named_value.name => named_value }

  api_management_name = azurerm_api_management.main.name
  display_name        = coalesce(each.value.display_name, each.value.name)
  name                = each.value.name
  resource_group_name = var.resource_group_name
  value               = each.value.value
  secret              = each.value.secret
}

moved {
  from = azurerm_api_management_named_value.named_values
  to   = azurerm_api_management_named_value.main
}
