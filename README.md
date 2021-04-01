# Azure API Management feature
[![Changelog](https://img.shields.io/badge/changelog-release-green.svg)](CHANGELOG.md) [![Notice](https://img.shields.io/badge/notice-copyright-yellow.svg)](NOTICE) [![Apache V2 License](https://img.shields.io/badge/license-Apache%20V2-orange.svg)](LICENSE) [![TF Registry](https://img.shields.io/badge/terraform-registry-blue.svg)](https://registry.terraform.io/modules/claranet/api-management/azurerm/)

This Terraform module creates an [Azure API Management](https://docs.microsoft.com/en-us/azure/api-management/).

## Requirements

* [AzureRM Terraform provider](https://www.terraform.io/docs/providers/azurerm/) >= 1.32

## Version compatibility

| Module version | Terraform version | AzureRM version |
|----------------|-------------------| --------------- |
| >= 4.x.x       | 0.13.x            | >= 2.0          |
| >= 3.x.x       | 0.12.x            | >= 2.0          |
| >= 2.x.x       | 0.12.x            | < 2.0           |
| <  2.x.x       | 0.11.x            | < 2.0           |

## Usage

This module is optimized to work with the [Claranet terraform-wrapper](https://github.com/claranet/terraform-wrapper) tool
which set some terraform variables in the environment needed by this module.
More details about variables set by the `terraform-wrapper` available in the [documentation](https://github.com/claranet/terraform-wrapper#environment).

You can use this module by including it this way:

```hcl
module "azure-region" {
  source  = "claranet/regions/azurerm"
  version = "x.x.x"

  azure_region = var.azure_region
}

module "rg" {
  source  = "claranet/rg/azurerm"
  version = "x.x.x"

  location    = module.azure-region.location
  client_name = var.client_name
  environment = var.environment
  stack       = var.stack
}

module "apim" {
  source  = "claranet/rg/api-management"
  version = "x.x.x"

  location       = module.azure-region.location
  location_short = module.azure-region.location_short
  client_name    = var.client_name
  environment    = var.environment
  stack          = var.stack

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
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| additional\_location | The name of the Azure Region in which the API Management Service should be expanded to. | `list(string)` | `[]` | no |
| certificate\_configuration | List of certificate configurations | `list(map(string))` | `[]` | no |
| client\_name | Client name/account used in naming | `string` | n/a | yes |
| create\_management\_rule | Whether to create the NSG rule for the management port of the APIM. If true, nsg\_name variable must be set | `bool` | `false` | no |
| create\_product\_group\_and\_relationships | Create local APIM groups with name identical to products and create a relationship between groups and products | `bool` | `false` | no |
| custom\_name | Custom API Management name, generated if not set | `string` | `""` | no |
| developer\_portal\_hostname\_configuration | Developer portal hostname configurations | `list(map(string))` | `[]` | no |
| diag\_settings\_name | Custom name for the diagnostic settings of Application Gateway. | `string` | `""` | no |
| enable\_http2 | Should HTTP/2 be supported by the API Management Service? | `bool` | `false` | no |
| enable\_sign\_in | Should anonymous users be redirected to the sign in page? | `bool` | `false` | no |
| enable\_sign\_up | Can users sign up on the development portal? | `bool` | `false` | no |
| environment | Project environment | `string` | n/a | yes |
| extra\_tags | Extra tags to add | `map(string)` | `{}` | no |
| identity\_type | Type of Managed Service Identity that should be configured on this API Management Service | `string` | `"SystemAssigned"` | no |
| location | Azure location for Eventhub. | `string` | n/a | yes |
| location\_short | Short string for Azure location. | `string` | n/a | yes |
| log\_categories | List of log categories to send | `list(string)` | `null` | no |
| logs\_destinations\_ids | List of destination resources IDs for logs diagnostic destination. Can be Storage Account, Log Analytics Workspace and Event Hub. No more than one of each can be set. | `list(string)` | `[]` | no |
| logs\_storage\_retention | Retention in days for logs on Storage Account | `number` | `30` | no |
| management\_hostname\_configuration | List of management hostname configurations | `list(map(string))` | `[]` | no |
| metric\_categories | List of metric categories to send | `list(string)` | `null` | no |
| name\_prefix | Optional prefix for Network Security Group name | `string` | `""` | no |
| named\_values | Map containing the name of the named values as key and value as values | `list(map(string))` | `[]` | no |
| notification\_sender\_email | Email address from which the notification will be sent | `string` | `null` | no |
| nsg\_name | NSG name of the subnet hosting the APIM to add the rule to allow management if the APIM is private | `string` | `null` | no |
| nsg\_rg\_name | Name of the RG hosting the NSG if it's different from the one hosting the APIM | `string` | `null` | no |
| policy\_configuration | Map of policy configuration | `map(string)` | `{}` | no |
| portal\_hostname\_configuration | Legacy portal hostname configurations | `list(map(string))` | `[]` | no |
| products | List of products to create | `list(string)` | `[]` | no |
| proxy\_hostname\_configuration | List of proxy hostname configurations | `list(map(string))` | `[]` | no |
| publisher\_email | The email of publisher/company. | `string` | n/a | yes |
| publisher\_name | The name of publisher/company. | `string` | n/a | yes |
| resource\_group\_name | Name of the resource group | `string` | n/a | yes |
| scm\_hostname\_configuration | List of scm hostname configurations | `list(map(string))` | `[]` | no |
| security\_configuration | Map of security configuration | `map(string)` | `{}` | no |
| sku\_name | String consisting of two parts separated by an underscore. The fist part is the name, valid values include: Developer, Basic, Standard and Premium. The second part is the capacity | `string` | `"Basic_1"` | no |
| stack | Project stack name | `string` | n/a | yes |
| terms\_of\_service\_configuration | Map of terms of service configuration | `list(map(string))` | `[]` | no |
| virtual\_network\_configuration | The id(s) of the subnet(s) that will be used for the API Management. Required when virtual\_network\_type is External or Internal | `list(string)` | `[]` | no |
| virtual\_network\_type | The type of virtual network you want to use, valid values include: None, External, Internal. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| api\_management\_additional\_location | Map listing gateway\_regional\_url and public\_ip\_addresses associated |
| api\_management\_gateway\_regional\_url | The Region URL for the Gateway of the API Management Service |
| api\_management\_gateway\_url | The URL of the Gateway for the API Management Service |
| api\_management\_id | The ID of the API Management Service |
| api\_management\_identity | The identity of the API Management |
| api\_management\_management\_api\_url | The URL for the Management API associated with this API Management service |
| api\_management\_name | The name of the API Management Service |
| api\_management\_portal\_url | The URL for the Publisher Portal associated with this API Management service |
| api\_management\_private\_ip\_addresses | The Private IP addresses of the API Management Service |
| api\_management\_public\_ip\_addresses | The Public IP addresses of the API Management Service |
| api\_management\_scm\_url | The URL for the SCM Endpoint associated with this API Management service |

## Related documentation

Terraform resource documentation on API Management: [https://www.terraform.io/docs/providers/azurerm/r/api_management.html](https://www.terraform.io/docs/providers/azurerm/r/api_management.html)

Microsoft Azure documentation: [https://docs.microsoft.com/en-us/azure/api-management/](https://docs.microsoft.com/en-us/azure/api-management/)
