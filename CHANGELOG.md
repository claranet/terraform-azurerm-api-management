## 7.0.0 (2024-06-21)


### ⚠ BREAKING CHANGES

* tf `v1.3+` required and provider AzureRM `v3.108+`

### Features

* refactor APIM module debdd4a


### Code Refactoring

* update `named_values` variable type 275bcc1
* update `variables.tf` 8401eef


### Continuous Integration

* **AZ-1391:** enable semantic-release [skip ci] f589d16
* **AZ-1391:** update semantic-release config [skip ci] 3d48a51


### Miscellaneous Chores

* **deps:** add renovate.json 5160a45
* **deps:** enable automerge on renovate d298dc1
* **deps:** update dependency opentofu to v1.7.0 4aaf6ac
* **deps:** update dependency opentofu to v1.7.1 b1496ca
* **deps:** update dependency opentofu to v1.7.2 c956401
* **deps:** update dependency pre-commit to v3.7.1 dddd2f3
* **deps:** update dependency terraform-docs to v0.18.0 e1171c1
* **deps:** update dependency tflint to v0.51.0 9675b83
* **deps:** update dependency tflint to v0.51.1 f6b69ab
* **deps:** update dependency trivy to v0.50.2 7f8ae88
* **deps:** update dependency trivy to v0.50.4 e545997
* **deps:** update dependency trivy to v0.51.0 bab7ec3
* **deps:** update dependency trivy to v0.51.1 b38ba55
* **deps:** update dependency trivy to v0.51.2 cc22d34
* **deps:** update dependency trivy to v0.51.3 6363cd0
* **deps:** update dependency trivy to v0.51.4 2585242
* **deps:** update dependency trivy to v0.52.0 440301d
* **deps:** update dependency trivy to v0.52.1 1b34e7c
* **deps:** update dependency trivy to v0.52.2 5b1da7c
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.92.0 9b36f88
* **deps:** update renovate.json 703e1d7
* **pre-commit:** update commitlint hook 92591d1
* **release:** remove legacy `VERSION` file ae59c6e

# v6.2.0 - 2023-11-17

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
