# Azure API Management
[![Changelog](https://img.shields.io/badge/changelog-release-green.svg)](CHANGELOG.md) [![Notice](https://img.shields.io/badge/notice-copyright-blue.svg)](NOTICE) [![Apache V2 License](https://img.shields.io/badge/license-Apache%20V2-orange.svg)](LICENSE) [![OpenTofu Registry](https://img.shields.io/badge/opentofu-registry-yellow.svg)](https://search.opentofu.org/module/claranet/api-management/azurerm/)

This Terraform module creates an [Azure API Management](https://docs.microsoft.com/en-us/azure/api-management/).

<!-- BEGIN_TF_DOCS -->
## Global versioning rule for Claranet Azure modules

| Module version | Terraform version | OpenTofu version | AzureRM version |
| -------------- | ----------------- | ---------------- | --------------- |
| >= 8.x.x       | **Unverified**    | 1.8.x            | >= 4.0          |
| >= 7.x.x       | 1.3.x             |                  | >= 3.0          |
| >= 6.x.x       | 1.x               |                  | >= 3.0          |
| >= 5.x.x       | 0.15.x            |                  | >= 2.0          |
| >= 4.x.x       | 0.13.x / 0.14.x   |                  | >= 2.0          |
| >= 3.x.x       | 0.12.x            |                  | >= 2.0          |
| >= 2.x.x       | 0.12.x            |                  | < 2.0           |
| <  2.x.x       | 0.11.x            |                  | < 2.0           |

## Contributing

If you want to contribute to this repository, feel free to use our [pre-commit](https://pre-commit.com/) git hook configuration
which will help you automatically update and format some files for you by enforcing our Terraform code module best-practices.

More details are available in the [CONTRIBUTING.md](./CONTRIBUTING.md#pull-request-process) file.

## Usage

This module is optimized to work with the [Claranet terraform-wrapper](https://github.com/claranet/terraform-wrapper) tool
which set some terraform variables in the environment needed by this module.
More details about variables set by the `terraform-wrapper` available in the [documentation](https://github.com/claranet/terraform-wrapper#environment).

⚠️ Since modules version v8.0.0, we do not maintain/check anymore the compatibility with
[Hashicorp Terraform](https://github.com/hashicorp/terraform/). Instead, we recommend to use [OpenTofu](https://github.com/opentofu/opentofu/).

```hcl
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
```

## Providers

| Name | Version |
|------|---------|
| azurecaf | ~> 1.2.28 |
| azurerm | ~> 4.31 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| diagnostics | claranet/diagnostic-settings/azurerm | ~> 8.0.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_api_management.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management) | resource |
| [azurerm_api_management_backend.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_backend) | resource |
| [azurerm_api_management_group.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_group) | resource |
| [azurerm_api_management_named_value.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_named_value) | resource |
| [azurerm_api_management_policy.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_policy) | resource |
| [azurerm_api_management_product.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_product) | resource |
| [azurerm_api_management_product_group.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_product_group) | resource |
| [azurerm_api_management_product_policy.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_product_policy) | resource |
| [azurerm_network_security_rule.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurecaf_name.apim](https://registry.terraform.io/providers/claranet/azurecaf/latest/docs/data-sources/name) | data source |
| [azurecaf_name.apim_nsg_rule](https://registry.terraform.io/providers/claranet/azurecaf/latest/docs/data-sources/name) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| additional\_locations | List of Azure Regions in which the API Management service should be expanded to. | <pre>list(object({<br/>    location             = string<br/>    capacity             = optional(number)<br/>    zones                = optional(list(number), [1, 2, 3])<br/>    public_ip_address_id = optional(string)<br/>    subnet_id            = optional(string)<br/>  }))</pre> | `[]` | no |
| backends | List of backend configurations for the API Management service. | <pre>list(object({<br/>    name        = string<br/>    protocol    = string<br/>    url         = string<br/>    description = optional(string)<br/>    resource_id = optional(string)<br/>    title       = optional(string)<br/><br/>    credentials = optional(object({<br/>      authorization = optional(object({<br/>        parameter = string<br/>        scheme    = string<br/>      }))<br/>      certificate = optional(list(string))<br/>      header      = optional(map(string))<br/>      query       = optional(map(string))<br/>    }))<br/><br/>    proxy = optional(object({<br/>      url      = string<br/>      username = string<br/>      password = string<br/>    }))<br/><br/>    tls = optional(object({<br/>      validate_certificate_chain = optional(bool)<br/>      validate_certificate_name  = optional(bool)<br/>    }))<br/>  }))</pre> | `[]` | no |
| certificate\_configurations | List of certificate configurations. | <pre>list(object({<br/>    encoded_certificate  = string<br/>    certificate_password = optional(string)<br/>    store_name           = string<br/>  }))</pre> | `[]` | no |
| client\_certificate\_enabled | (Optional) Enforce a client certificate to be presented on each request to the gateway? This is only supported when SKU type is `Consumption`. | `bool` | `false` | no |
| client\_name | Client name/account used in naming. | `string` | n/a | yes |
| create\_management\_rule | Whether to create the NSG rule for the management port of the APIM. If true, nsg\_name variable must be set. | `bool` | `false` | no |
| custom\_name | Custom API Management name, generated if not set. | `string` | `""` | no |
| default\_tags\_enabled | Option to enable or disable default tags. | `bool` | `true` | no |
| developer\_portal\_hostname\_configurations | Developer Portal hostname configurations. | <pre>list(object({<br/>    host_name                    = string<br/>    key_vault_id                 = optional(string)<br/>    certificate                  = optional(string)<br/>    certificate_password         = optional(string)<br/>    negotiate_client_certificate = optional(bool, false)<br/>  }))</pre> | `[]` | no |
| diagnostic\_settings\_custom\_name | Custom name of the diagnostics settings, name will be `default` if not set. | `string` | `"default"` | no |
| environment | Project environment. | `string` | n/a | yes |
| extra\_tags | Extra tags to add. | `map(string)` | `{}` | no |
| gateway\_enabled | Whether enable or disable the gateway in main region? Can be disabled only when `additional_locations` is set. | `bool` | `true` | no |
| groups | List of Groups to create with options. | <pre>list(object({<br/>    name         = optional(string)<br/>    display_name = string<br/>    description  = optional(string)<br/>    type         = optional(string)<br/>    external_id  = optional(string)<br/>  }))</pre> | `[]` | no |
| http2\_enabled | Should HTTP/2 be supported by the API Management Service? | `bool` | `false` | no |
| identity\_ids | A list of IDs for User Assigned Managed Identity resources to be assigned. This is required when type is set to `UserAssigned` or `SystemAssigned, UserAssigned`. | `list(string)` | `null` | no |
| identity\_type | Type of Managed Service Identity that should be configured on this API Management Service. | `string` | `"SystemAssigned"` | no |
| location | Azure location. | `string` | n/a | yes |
| location\_short | Short string for Azure location. | `string` | n/a | yes |
| logs\_categories | Log categories to send to destinations. | `list(string)` | `null` | no |
| logs\_destinations\_ids | List of destination resources IDs for logs diagnostic destination.<br/>Can be `Storage Account`, `Log Analytics Workspace` and `Event Hub`. No more than one of each can be set.<br/>If you want to use Azure EventHub as a destination, you must provide a formatted string containing both the EventHub Namespace authorization send ID and the EventHub name (name of the queue to use in the Namespace) separated by the <code>&#124;</code> character. | `list(string)` | n/a | yes |
| logs\_metrics\_categories | Metrics categories to send to destinations. | `list(string)` | `null` | no |
| management\_hostname\_configurations | List of management hostname configurations. | <pre>list(object({<br/>    host_name                    = string<br/>    key_vault_id                 = optional(string)<br/>    certificate                  = optional(string)<br/>    certificate_password         = optional(string)<br/>    negotiate_client_certificate = optional(bool, false)<br/>  }))</pre> | `[]` | no |
| management\_nsg\_rule\_priority | Priority of the NSG rule created for the management port of the APIM. | `number` | `101` | no |
| management\_rule\_custom\_name | Custom NSG rule name for APIM Management. | `string` | `""` | no |
| min\_api\_version | (Optional) The version which the control plane API calls to API Management service are limited with version equal to or newer than. | `string` | `null` | no |
| name\_prefix | Optional prefix for the generated name. | `string` | `""` | no |
| name\_suffix | Optional suffix for the generated name. | `string` | `""` | no |
| named\_values | Named values configurations. | <pre>list(object({<br/>    name         = string<br/>    display_name = optional(string)<br/>    value        = string<br/>    secret       = optional(bool, false)<br/>  }))</pre> | `[]` | no |
| notification\_sender\_email | Email address from which the notification will be sent. | `string` | `null` | no |
| nsg\_name | NSG name of the subnet hosting the APIM to add the rule to allow management if the APIM is private. | `string` | `null` | no |
| nsg\_rg\_name | Name of the RG hosting the NSG if it's different from the one hosting the APIM. | `string` | `null` | no |
| policy\_configurations | Policies configurations. | <pre>list(object({<br/>    name        = optional(string, "default")<br/>    xml_content = optional(string)<br/>    xml_link    = optional(string)<br/>  }))</pre> | `[]` | no |
| portal\_hostname\_configurations | Legacy Portal hostname configurations. | <pre>list(object({<br/>    host_name                    = string<br/>    key_vault_id                 = optional(string)<br/>    certificate                  = optional(string)<br/>    certificate_password         = optional(string)<br/>    negotiate_client_certificate = optional(bool, false)<br/>  }))</pre> | `[]` | no |
| products | List of Products to create with options and Groups to associate to. | <pre>list(object({<br/>    product_id            = optional(string)<br/>    display_name          = string<br/>    description           = optional(string)<br/>    terms                 = optional(string)<br/>    subscription_required = optional(bool, true)<br/>    approval_required     = optional(bool, false)<br/>    published             = optional(bool, true)<br/>    subscriptions_limit   = optional(number, 1)<br/>    groups_names          = optional(list(string), [])<br/>    policy                = optional(string)<br/>  }))</pre> | `[]` | no |
| proxy\_hostname\_configurations | List of proxy hostname configurations. | <pre>list(object({<br/>    host_name                    = string<br/>    key_vault_id                 = optional(string)<br/>    certificate                  = optional(string)<br/>    certificate_password         = optional(string)<br/>    default_ssl_binding          = optional(bool, false)<br/>    negotiate_client_certificate = optional(bool, false)<br/>  }))</pre> | `[]` | no |
| publisher\_email | The email of publisher/company. | `string` | n/a | yes |
| publisher\_name | The name of publisher/company. | `string` | n/a | yes |
| resource\_group\_name | Resource group name. | `string` | n/a | yes |
| scm\_hostname\_configurations | List of SCM hostname configurations. | <pre>list(object({<br/>    host_name                    = string<br/>    key_vault_id                 = optional(string)<br/>    certificate                  = optional(string)<br/>    certificate_password         = optional(string)<br/>    negotiate_client_certificate = optional(bool, false)<br/>  }))</pre> | `[]` | no |
| security\_configuration | Security configuration block. | <pre>object({<br/>    backend_ssl30_enabled  = optional(bool, false)<br/>    backend_tls10_enabled  = optional(bool, false)<br/>    backend_tls11_enabled  = optional(bool, false)<br/>    frontend_ssl30_enabled = optional(bool, false)<br/>    frontend_tls10_enabled = optional(bool, false)<br/>    frontend_tls11_enabled = optional(bool, false)<br/><br/>    tls_ecdhe_ecdsa_with_aes128_cbc_sha_ciphers_enabled = optional(bool, false)<br/>    tls_ecdhe_ecdsa_with_aes256_cbc_sha_ciphers_enabled = optional(bool, false)<br/>    tls_ecdhe_rsa_with_aes128_cbc_sha_ciphers_enabled   = optional(bool, false)<br/>    tls_ecdhe_rsa_with_aes256_cbc_sha_ciphers_enabled   = optional(bool, false)<br/>    tls_rsa_with_aes128_cbc_sha256_ciphers_enabled      = optional(bool, false)<br/>    tls_rsa_with_aes128_cbc_sha_ciphers_enabled         = optional(bool, false)<br/>    tls_rsa_with_aes128_gcm_sha256_ciphers_enabled      = optional(bool, false)<br/>    tls_rsa_with_aes256_cbc_sha256_ciphers_enabled      = optional(bool, false)<br/>    tls_rsa_with_aes256_cbc_sha_ciphers_enabled         = optional(bool, false)<br/><br/>    triple_des_ciphers_enabled = optional(bool, false)<br/>  })</pre> | `null` | no |
| sign\_in\_enabled | Should anonymous users be redirected to the sign in page? | `bool` | `false` | no |
| sign\_up\_enabled | Can users sign up on the development portal? | `bool` | `false` | no |
| sku\_capacity | APIM SKU capacity. | `number` | `1` | no |
| sku\_tier | APIM SKU. Valid values include: Developer, Basic, Standard, StandardV2 and Premium. | `string` | `"Premium"` | no |
| stack | Project stack name. | `string` | n/a | yes |
| subnet\_id | ID of the Subnet that will be used for the API Management in current location. Required when `var.virtual_network_type` is `External` or `Internal`. | `string` | `null` | no |
| terms\_of\_service\_configuration | Terms of service configuration. | <pre>object({<br/>    consent_required = optional(bool, false)<br/>    enabled          = optional(bool, false)<br/>    text             = optional(string, "")<br/>  })</pre> | `{}` | no |
| virtual\_network\_type | The type of Virtual Network you want to use, valid values include: `None`, `External` and `Internal`. Defaults to `None`. | `string` | `"None"` | no |
| zones | Specifies a list of Availability Zones in which this API Management service should be located. Changing this forces a new API Management service to be created. Supported in Premium Tier. | `list(number)` | <pre>[<br/>  1,<br/>  2,<br/>  3<br/>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| additional\_locations | Map listing `gateway_regional_url` and `public_ip_addresses` associated. |
| gateway\_regional\_url | The gateway's regional URL of the API Management Service. |
| gateway\_url | The gateway's URL of the API Management Service. |
| id | The ID of the API Management Service. |
| identity\_principal\_id | API Management system identity principal ID. |
| management\_api\_url | The management's API URL of the API Management service. |
| module\_diagnostics | Diagnostics settings module outputs. |
| name | The name of the API Management Service. |
| portal\_url | The publisher portal's URL of the API Management service. |
| private\_ip\_addresses | The Private IP addresses of the API Management Service. |
| public\_ip\_addresses | The Public IP addresses of the API Management Service. |
| resource | The API Management Service resource object. |
| resource\_groups | List of groups created in the API Management instance. |
| resource\_products | List of products created in the API Management instance. |
| resource\_products\_groups | List of products and groups associations created in the API Management instance. |
| resource\_products\_policies | List of policies associated with products in the API Management instance. |
| scm\_url | The SCM Endpoint's URL of the API Management service. |
<!-- END_TF_DOCS -->

## Related documentation

Microsoft Azure documentation: [https://docs.microsoft.com/en-us/azure/api-management/](https://docs.microsoft.com/en-us/azure/api-management/)
