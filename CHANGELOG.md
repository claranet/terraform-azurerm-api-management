# Unreleased

Breaking
  * AZ-1247: Remove `retention_days` parameters, it must be handled at destination level now. (for reference: [Provider issue](https://github.com/hashicorp/terraform-provider-azurerm/issues/23051))

# v6.1.1 - 2023-04-13

Fixed
  * [GH-4](https://github.com/claranet/terraform-azurerm-api-management/pull/4): Make `sign_in` and `sign_up` blocks conditional
  * AZ-1037: Update examples with `run` module

# v6.1.0 - 2022-11-28

Breaking
  * AZ-908: Implement Azure CAF naming (using Microsoft provider)

Changed
  * AZ-908: Bump `diagnostics-settings`

# v6.0.0 - 2022-05-20

Breaking
  * AZ-717: Require Terraform 1.0+
  * AZ-717: Bump AzureRM provider version to `v3.0+`

# v4.3.0 - 2022-02-04

Breaking
  * AZ-589: Upgrade `diagnostics` to `v5.0.0`
  * AZ-589: Variables name cleanup
  * AZ-515: Require Terraform 0.13+

Added
  * AZ-615: Add an option to enable or disable default tags
  * AZ-615: Add a default value to `terms_of_service_configuration` variable (required since AzureRM v2.26)

Fixed
  * AZ-589: Avoid plan drift when specifying Diagnostic Settings categories

Changed
  * AZ-572: Revamp examples and improve CI

# v4.2.0 - 2021-08-27

Fixed
  * AZ-530: Fix provider required version

Changed
  * AZ-532: Revamp README with latest `terraform-docs` tool
  * AZ-530: Cleanup module, fix linter errors

# v4.1.0 - 2021-04-01

Added
  * AZ-373: Add diagnostic settings, add NSG rule for APIM Management interface
  * AZ-475: Add `log_destination_type` variable

Changed
  * AZ-409: Finalizing the Additional location feature (Added vNET configuration)

# v3.2.0/v4.0.0 - 2020-12-11

Updated
  * AZ-273: Module now compatible terraform `v0.13+`

Added
  * AZ-264: Added output for private IP addresses

Fixed
  * AZ-358: Fix RPC Error when using empty `hostname_configurations`

# v3.1.0 - 2020-12-01

Added
  * AZ-264: Added new variable to handle identity plus corresponding output
  * AZ-272: named values, products, groups and their relationships

# v3.0.0 - 2020-07-09

Breaking
  * AZ-221: AzureRM provider 2.0 compatibility


# v2.0.0 - 2020-06-11

Added
  * AZ-228: Azure API Management - First Release
