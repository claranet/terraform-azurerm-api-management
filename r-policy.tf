resource "azurerm_api_management_policy" "policy" {
  for_each = { for p in var.policy_configuration : p.name => p }

  api_management_id = azurerm_api_management.apim.id

  xml_content = each.value.xml_content
  xml_link    = each.value.xml_link
}
