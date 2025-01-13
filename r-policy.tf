resource "azurerm_api_management_policy" "main" {
  for_each = { for p in var.policy_configurations : p.name => p }

  api_management_id = azurerm_api_management.main.id

  xml_content = each.value.xml_content
  xml_link    = each.value.xml_link
}

moved {
  from = azurerm_api_management_policy.policy
  to   = azurerm_api_management_policy.main
}
