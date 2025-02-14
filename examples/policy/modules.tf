module "apim" {
  source  = "claranet/api-management/azurerm"
  version = "x.x.x"

  location       = module.azure_region.location
  location_short = module.azure_region.location_short
  client_name    = var.client_name
  environment    = var.environment
  stack          = var.stack

  resource_group_name = module.rg.name

  sku_tier     = "Standard"
  sku_capacity = 1

  publisher_name  = "Contoso ApiManager"
  publisher_email = "api_manager@test.com"

  policy_configurations = [
    { #https://learn.microsoft.com/en-us/azure/api-management/front-door-api-management#restrict-incoming-ip-addresses / https://learn.microsoft.com/en-us/azure/api-management/check-header-policy
      name = "afd-policy"
      xml_content = templatefile("${path.module}/policy.tftpl", {
        allowed_cidrs = local.allowed_cidrs
        afd_guid      = local.afd_guid
      })
    },
  ]

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

  additional_locations = [{
    location  = "eastus2"
    subnet_id = var.subnet_id
  }]

  logs_destinations_ids = [
    module.logs.storage_account_id,
    module.logs.id
  ]
}
