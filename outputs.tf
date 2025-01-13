output "resource" {
  description = "The API Management Service resource object."
  value       = azurerm_api_management.main
}

output "module_diagnostics" {
  description = "Diagnostics settings module outputs."
  value       = module.diagnostics
}

output "name" {
  description = "The name of the API Management Service."
  value       = azurerm_api_management.main.name
}

output "id" {
  description = "The ID of the API Management Service."
  value       = azurerm_api_management.main.id
}

output "additional_locations" {
  description = "Map listing `gateway_regional_url` and `public_ip_addresses` associated."
  value       = azurerm_api_management.main.additional_location
}

output "gateway_url" {
  description = "The gateway's URL of the API Management Service."
  value       = azurerm_api_management.main.gateway_url
}

output "gateway_regional_url" {
  description = "The gateway's regional URL of the API Management Service."
  value       = azurerm_api_management.main.gateway_regional_url
}

output "management_api_url" {
  description = "The management's API URL of the API Management service."
  value       = azurerm_api_management.main.management_api_url
}

output "portal_url" {
  description = "The publisher portal's URL of the API Management service."
  value       = azurerm_api_management.main.portal_url
}

output "public_ip_addresses" {
  description = "The Public IP addresses of the API Management Service."
  value       = azurerm_api_management.main.public_ip_addresses
}

output "private_ip_addresses" {
  description = "The Private IP addresses of the API Management Service."
  value       = azurerm_api_management.main.private_ip_addresses
}

output "scm_url" {
  description = "The SCM Endpoint's URL of the API Management service."
  value       = azurerm_api_management.main.scm_url
}

output "identity_principal_id" {
  description = "API Management system identity principal ID."
  value       = try(azurerm_api_management.main.identity[0].principal_id, null)
}
