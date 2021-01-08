module "logging" {
  source  = "claranet/diagnostic-settings/azurerm"
  version = "4.0.1"

  name = local.diag_settings_name

  logs_destinations_ids = var.logs_destinations_ids
  resource_id           = azurerm_api_management.apim.id
  retention_days        = var.logs_storage_retention

  log_categories    = var.log_categories
  metric_categories = var.metric_categories
}
