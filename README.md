# Azure API Management feature
[![Changelog](https://img.shields.io/badge/changelog-release-green.svg)](CHANGELOG.md) [![Notice](https://img.shields.io/badge/notice-copyright-blue.svg)](NOTICE) [![Apache V2 License](https://img.shields.io/badge/license-Apache%20V2-orange.svg)](LICENSE) [![OpenTofu Registry](https://img.shields.io/badge/opentofu-registry-yellow.svg)](https://search.opentofu.org/module/claranet/api-management/azurerm/)

This Terraform module creates an [Azure API Management](https://docs.microsoft.com/en-us/azure/api-management/).

## Requirements

* [AzureRM Terraform provider](https://www.terraform.io/docs/providers/azurerm/) >= 1.32

<!-- BEGIN_TF_DOCS -->
## Global versioning rule for Claranet Azure modules

| Module version | Terraform version | AzureRM version |
| -------------- | ----------------- | --------------- |
| >= 7.x.x       | 1.3.x             | >= 3.0          |
| >= 6.x.x       | 1.x               | >= 3.0          |
| >= 5.x.x       | 0.15.x            | >= 2.0          |
| >= 4.x.x       | 0.13.x / 0.14.x   | >= 2.0          |
| >= 3.x.x       | 0.12.x            | >= 2.0          |
| >= 2.x.x       | 0.12.x            | < 2.0           |
| <  2.x.x       | 0.11.x            | < 2.0           |

## Contributing

If you want to contribute to this repository, feel free to use our [pre-commit](https://pre-commit.com/) git hook configuration
which will help you automatically update and format some files for you by enforcing our Terraform code module best-practices.

More details are available in the [CONTRIBUTING.md](./CONTRIBUTING.md#pull-request-process) file.

## Usage

This module is optimized to work with the [Claranet terraform-wrapper](https://github.com/claranet/terraform-wrapper) tool
which set some terraform variables in the environment needed by this module.
More details about variables set by the `terraform-wrapper` available in the [documentation](https://github.com/claranet/terraform-wrapper#environment).

```hcl
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

  sku_tier     = "Standard"
  sku_capacity = 1

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
```

## Providers

| Name | Version |
|------|---------|
| azurecaf | ~> 1.2, >= 1.2.22 |
| azurerm | ~> 3.108 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| diagnostics | claranet/diagnostic-settings/azurerm | ~> 6.5.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_api_management.apim](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management) | resource |
| [azurerm_api_management_group.group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_group) | resource |
| [azurerm_api_management_named_value.named_values](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_policy.policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_policy) | resource |
| [azurerm_api_management_product.product](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_product) | resource |
| [azurerm_api_management_product_group.product_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_product_group) | resource |
| [azurerm_network_security_rule.management_apim](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurecaf_name.apim](https://registry.terraform.io/providers/claranet/azurecaf/latest/docs/data-sources/name) | data source |
| [azurecaf_name.apim_nsg_rule](https://registry.terraform.io/providers/claranet/azurecaf/latest/docs/data-sources/name) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| additional\_location | List of the Azure Region in which the API Management Service should be expanded to. | <pre>list(object({<br>    location             = string<br>    capacity             = optional(number)<br>    zones                = optional(list(number), [1, 2, 3])<br>    public_ip_address_id = optional(string)<br>    subnet_id            = optional(string)<br>  }))</pre> | `[]` | no |
| certificate\_configuration | List of certificate configurations. | <pre>list(object({<br>    encoded_certificate  = string<br>    certificate_password = optional(string)<br>    store_name           = string<br>  }))</pre> | `[]` | no |
| client\_certificate\_enabled | (Optional) Enforce a client certificate to be presented on each request to the gateway? This is only supported when SKU type is `Consumption`. | `bool` | `false` | no |
| client\_name | Client name/account used in naming. | `string` | n/a | yes |
| create\_management\_rule | Whether to create the NSG rule for the management port of the APIM. If true, nsg\_name variable must be set | `bool` | `false` | no |
| create\_product\_group\_and\_relationships | Create local APIM groups with name identical to products and create a relationship between groups and products. | `bool` | `false` | no |
| custom\_diagnostic\_settings\_name | Custom name of the diagnostics settings, name will be 'default' if not set. | `string` | `"default"` | no |
| custom\_management\_rule\_name | Custom NSG rule name for APIM Management. | `string` | `""` | no |
| custom\_name | Custom API Management name, generated if not set. | `string` | `""` | no |
| default\_tags\_enabled | Option to enable or disable default tags | `bool` | `true` | no |
| developer\_portal\_hostname\_configuration | Developer Portal hostname configurations. | <pre>list(object({<br>    host_name                    = string<br>    key_vault_id                 = optional(string)<br>    certificate                  = optional(string)<br>    certificate_password         = optional(string)<br>    negotiate_client_certificate = optional(bool, false)<br>  }))</pre> | `[]` | no |
| enable\_http2 | Should HTTP/2 be supported by the API Management Service? | `bool` | `false` | no |
| environment | Project environment. | `string` | n/a | yes |
| extra\_tags | Extra tags to add | `map(string)` | `{}` | no |
| gateway\_disabled | (Optional) Disable the gateway in main region? This is only supported when `additional_location` is set. | `bool` | `false` | no |
| identity\_ids | A list of IDs for User Assigned Managed Identity resources to be assigned. This is required when type is set to `UserAssigned` or `SystemAssigned, UserAssigned`. | `list(string)` | `[]` | no |
| identity\_type | Type of Managed Service Identity that should be configured on this API Management Service. | `string` | `"SystemAssigned"` | no |
| location | Azure location for Eventhub. | `string` | n/a | yes |
| location\_short | Short string for Azure location. | `string` | n/a | yes |
| logs\_categories | Log categories to send to destinations. | `list(string)` | `null` | no |
| logs\_destinations\_ids | List of destination resources IDs for logs diagnostic destination.<br>Can be `Storage Account`, `Log Analytics Workspace` and `Event Hub`. No more than one of each can be set.<br>If you want to specify an Azure EventHub to send logs and metrics to, you need to provide a formated string with both the EventHub Namespace authorization send ID and the EventHub name (name of the queue to use in the Namespace) separated by the `|` character. | `list(string)` | n/a | yes |
| logs\_metrics\_categories | Metrics categories to send to destinations. | `list(string)` | `null` | no |
| management\_hostname\_configuration | List of management hostname configurations. | <pre>list(object({<br>    host_name                    = string<br>    key_vault_id                 = optional(string)<br>    certificate                  = optional(string)<br>    certificate_password         = optional(string)<br>    negotiate_client_certificate = optional(bool, false)<br>  }))</pre> | `[]` | no |
| management\_nsg\_rule\_priority | Priority of the NSG rule created for the management port of the APIM | `number` | `101` | no |
| min\_api\_version | (Optional) The version which the control plane API calls to API Management service are limited with version equal to or newer than. | `string` | `null` | no |
| name\_prefix | Optional prefix for the generated name | `string` | `""` | no |
| name\_suffix | Optional suffix for the generated name | `string` | `""` | no |
| named\_values | Named values configurations. | <pre>list(object({<br>    name         = string<br>    display_name = optional(string)<br>    value        = string<br>    secret       = optional(bool, false)<br>  }))</pre> | `[]` | no |
| notification\_sender\_email | Email address from which the notification will be sent. | `string` | `null` | no |
| nsg\_name | NSG name of the subnet hosting the APIM to add the rule to allow management if the APIM is private | `string` | `null` | no |
| nsg\_rg\_name | Name of the RG hosting the NSG if it's different from the one hosting the APIM | `string` | `null` | no |
| policy\_configuration | Policies configurations. | <pre>list(object({<br>    name        = optional(string, "default")<br>    xml_content = optional(string)<br>    xml_link    = optional(string)<br>  }))</pre> | `[]` | no |
| portal\_hostname\_configuration | Legacy Portal hostname configurations. | <pre>list(object({<br>    host_name                    = string<br>    key_vault_id                 = optional(string)<br>    certificate                  = optional(string)<br>    certificate_password         = optional(string)<br>    negotiate_client_certificate = optional(bool, false)<br>  }))</pre> | `[]` | no |
| products | List of products to create. | `list(string)` | `[]` | no |
| proxy\_hostname\_configuration | List of proxy hostname configurations. | <pre>list(object({<br>    host_name                    = string<br>    key_vault_id                 = optional(string)<br>    certificate                  = optional(string)<br>    certificate_password         = optional(string)<br>    negotiate_client_certificate = optional(bool, false)<br>  }))</pre> | `[]` | no |
| publisher\_email | The email of publisher/company. | `string` | n/a | yes |
| publisher\_name | The name of publisher/company. | `string` | n/a | yes |
| resource\_group\_name | Name of the resource group. | `string` | n/a | yes |
| scm\_hostname\_configuration | List of SCM hostname configurations. | <pre>list(object({<br>    host_name                    = string<br>    key_vault_id                 = optional(string)<br>    certificate                  = optional(string)<br>    certificate_password         = optional(string)<br>    negotiate_client_certificate = optional(bool, false)<br>  }))</pre> | `[]` | no |
| security\_configuration | Security configuration block. | <pre>object({<br>    enable_backend_ssl30  = optional(bool, false)<br>    enable_backend_tls10  = optional(bool, false)<br>    enable_backend_tls11  = optional(bool, false)<br>    enable_frontend_ssl30 = optional(bool, false)<br>    enable_frontend_tls10 = optional(bool, false)<br>    enable_frontend_tls11 = optional(bool, false)<br><br>    tls_ecdhe_ecdsa_with_aes128_cbc_sha_ciphers_enabled = optional(bool, false)<br>    tls_ecdhe_ecdsa_with_aes256_cbc_sha_ciphers_enabled = optional(bool, false)<br>    tls_ecdhe_rsa_with_aes128_cbc_sha_ciphers_enabled   = optional(bool, false)<br>    tls_ecdhe_rsa_with_aes256_cbc_sha_ciphers_enabled   = optional(bool, false)<br>    tls_rsa_with_aes128_cbc_sha256_ciphers_enabled      = optional(bool, false)<br>    tls_rsa_with_aes128_cbc_sha_ciphers_enabled         = optional(bool, false)<br>    tls_rsa_with_aes128_gcm_sha256_ciphers_enabled      = optional(bool, false)<br>    tls_rsa_with_aes256_cbc_sha256_ciphers_enabled      = optional(bool, false)<br>    tls_rsa_with_aes256_cbc_sha_ciphers_enabled         = optional(bool, false)<br><br>    triple_des_ciphers_enabled = optional(bool, false)<br>  })</pre> | `{}` | no |
| sign\_in\_enabled | Should anonymous users be redirected to the sign in page? | `bool` | `false` | no |
| sign\_up\_enabled | Can users sign up on the development portal? | `bool` | `false` | no |
| sku\_capacity | APIM SKU capacity. | `number` | `1` | no |
| sku\_tier | APIM SKU. Valid values include: Developer, Basic, Standard, StandardV2 and Premium. | `string` | `"Basic"` | no |
| stack | Project stack name. | `string` | n/a | yes |
| terms\_of\_service\_configuration | Terms of service configurations. | <pre>list(object({<br>    consent_required = optional(bool, false)<br>    enabled          = optional(bool, false)<br>    text             = optional(string, "")<br>  }))</pre> | `[]` | no |
| use\_caf\_naming | Use the Azure CAF naming provider to generate default resource name. `custom_name` override this if set. Legacy default name is used if this is set to `false`. | `bool` | `true` | no |
| virtual\_network\_configuration | The id(s) of the subnet(s) that will be used for the API Management. Required when virtual\_network\_type is External or Internal | `list(string)` | `[]` | no |
| virtual\_network\_type | The type of virtual network you want to use, valid values include: None, External, Internal. | `string` | `null` | no |
| zones | (Optional) Specifies a list of Availability Zones in which this API Management service should be located. Changing this forces a new API Management service to be created. Supported in Premium Tier. | `list(number)` | <pre>[<br>  1,<br>  2,<br>  3<br>]</pre> | no |

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
<!-- END_TF_DOCS -->
## Related documentation

Microsoft Azure documentation: [https://docs.microsoft.com/en-us/azure/api-management/](https://docs.microsoft.com/en-us/azure/api-management/)
