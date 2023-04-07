module "azure_region" {
  source  = "claranet/regions/azurerm"
  version = "x.x.x"

  azure_region = var.azure_region
}

module "rg" {
  source  = "claranet/rg/azurerm"
  version = "x.x.x"

  location    = module.azure_region.location
  client_name = var.client_name
  environment = var.environment
  stack       = var.stack
}

module "logs" {
  source  = "claranet/run/azurerm//modules/logs"
  version = "x.x.x"

  client_name         = var.client_name
  environment         = var.environment
  stack               = var.stack
  location            = module.azure_region.location
  location_short      = module.azure_region.location_short
  resource_group_name = module.rg.resource_group_name
}

module "apim" {
  source  = "claranet/api-management/azurerm"
  version = "x.x.x"

  location       = module.azure_region.location
  location_short = module.azure_region.location_short
  client_name    = var.client_name
  environment    = var.environment
  stack          = var.stack

  resource_group_name = module.rg.resource_group_name

  sku_name        = "Standard_1"
  publisher_name  = "Contoso ApiManager"
  publisher_email = "api_manager@test.com"

  named_values = [
    {
      name   = "my_named_value"
      value  = "my_secret_value"
      secret = true
    },
    {
      display_name = "My second value explained"
      name         = "my_second_value"
      value        = "my_not_secret_value"
    }
  ]

  additional_location = [
    {
      location  = "eastus2"
      subnet_id = var.subnet_id
    },
  ]

  logs_destinations_ids = [
    module.logs.logs_storage_account_id,
    module.logs.log_analytics_workspace_id
  ]
}
