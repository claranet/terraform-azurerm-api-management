module "diagnostics" {
  source  = "claranet/diagnostic-settings/azurerm"
  version = "6.2.0"

  resource_id = azurerm_api_management.apim.id

  logs_destinations_ids = var.logs_destinations_ids
  log_categories        = var.logs_categories
  metric_categories     = var.logs_metrics_categories
  retention_days        = var.logs_retention_days

  custom_name    = var.custom_diagnostic_settings_name
  use_caf_naming = false #var.use_caf_naming
  name_prefix    = var.name_prefix
  name_suffix    = var.name_suffix
}
