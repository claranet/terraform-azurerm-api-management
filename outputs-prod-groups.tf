output "resource_products" {
  description = "List of products created in the API Management instance."
  value       = azurerm_api_management_product.main
}

output "resource_groups" {
  description = "List of groups created in the API Management instance."
  value       = azurerm_api_management_group.main
}

output "resource_products_groups" {
  description = "List of products and groups associations created in the API Management instance."
  value       = azurerm_api_management_product_group.main
}
