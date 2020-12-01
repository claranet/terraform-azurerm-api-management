resource "azurerm_api_management_group" "group" {
  for_each            = var.create_product_group_and_relationships ? toset(var.products) : []
  name                = each.key
  resource_group_name = var.resource_group_name
  api_management_name = azurerm_api_management.apim.name
  display_name        = each.key
}

resource "azurerm_api_management_product" "product" {
  for_each              = toset(var.products)
  product_id            = each.key
  resource_group_name   = var.resource_group_name
  api_management_name   = azurerm_api_management.apim.name
  display_name          = each.key
  subscription_required = true
  approval_required     = true
  published             = true
  subscriptions_limit   = 1
}

resource "azurerm_api_management_product_group" "product_group" {
  for_each            = var.create_product_group_and_relationships ? toset(var.products) : []
  product_id          = each.key
  resource_group_name = var.resource_group_name
  api_management_name = azurerm_api_management.apim.name
  group_name          = each.key
}

