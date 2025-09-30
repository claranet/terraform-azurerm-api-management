## 8.2.1 (2025-09-30)

### Code Refactoring

* **deps:** 🔗 update claranet/azurecaf to ~> 1.3.0 🔧 ab82856

### Miscellaneous Chores

* **⚙️:** ✏️ update template identifier for MR review 14a2f66
* 🗑️ remove old commitlint configuration files c0ccd9d
* **deps:** 🔗 bump AzureRM provider version to v4.31+ fe41492
* **deps:** update dependency claranet/diagnostic-settings/azurerm to ~> 8.1.0 6cf0fd1
* **deps:** update dependency opentofu to v1.10.0 246d801
* **deps:** update dependency opentofu to v1.10.1 6fc9882
* **deps:** update dependency opentofu to v1.10.3 5d201fe
* **deps:** update dependency opentofu to v1.10.6 f8d9e9c
* **deps:** update dependency opentofu to v1.9.1 dd39e84
* **deps:** update dependency tflint to v0.57.0 82f5112
* **deps:** update dependency tflint to v0.58.0 32654bb
* **deps:** update dependency tflint to v0.58.1 a24bc2a
* **deps:** update dependency tflint to v0.59.1 383fb72
* **deps:** update dependency trivy to v0.61.1 0e0eacb
* **deps:** update dependency trivy to v0.62.0 ffc9bf8
* **deps:** update dependency trivy to v0.62.1 6138ded
* **deps:** update dependency trivy to v0.63.0 fcf0b07
* **deps:** update dependency trivy to v0.66.0 1ab1feb
* **deps:** update dependency trivy to v0.67.0 02cd0c9
* **deps:** update pre-commit hook pre-commit/pre-commit-hooks to v6 f05cfd8
* **deps:** update pre-commit hook tofuutils/pre-commit-opentofu to v2.2.1 b1e295d
* **deps:** update terraform claranet/diagnostic-settings/azurerm to ~> 8.2.0 33dd533
* **deps:** update tools 3d6bbd5
* **deps:** update tools d04ce4f
* **deps:** update tools fa0e469

## 8.2.0 (2025-04-11)

### Features

* **AZ-1547:** adds backend configuration support for API Management 1e80a38

### Code Refactoring

* apply mrAI suggestion 5fadda1

### Miscellaneous Chores

* apply 4 suggestion(s) to 2 file(s) fc732a2

## 8.1.0 (2025-04-11)

### Features

* **AZ-1547:** add Product Policies option 52e2a6b
* **AZ-1547:** handle Products and Groups with their options ede73d5

### Bug Fixes

* **AZ-1547:** more explicit pre-condition validations f6871e8

### Documentation

* add comment 0be8815
* add outputs b365285

### Miscellaneous Chores

* **deps:** update dependency pre-commit to v4.2.0 3c1867a
* **deps:** update dependency terraform-docs to v0.20.0 5f31701
* **deps:** update dependency tflint to v0.56.0 eff886e
* **deps:** update dependency trivy to v0.60.0 f4a84d5
* **deps:** update dependency trivy to v0.61.0 5ca1625
* **deps:** update pre-commit hook alessandrojcm/commitlint-pre-commit-hook to v9.21.0 416e0e3
* **deps:** update pre-commit hook alessandrojcm/commitlint-pre-commit-hook to v9.22.0 2a2afb9
* **deps:** update pre-commit hook tofuutils/pre-commit-opentofu to v2.2.0 8fbbd36

## 8.0.2 (2025-02-14)

### Bug Fixes

* **AZ-1515:** fix additional_locations precondition 7fb80f0

### Miscellaneous Chores

* **AZ-1513:** add policy example 8ec3950
* **deps:** update dependency trivy to v0.59.1 5876001

## 8.0.1 (2025-02-04)

### Bug Fixes

* **AZ-1511:** revert changes on resource_group_name for apim resource 1516980

### Miscellaneous Chores

* **deps:** update tools 39aba90
* update Github templates b6d50fb

## 8.0.0 (2025-01-24)

### ⚠ BREAKING CHANGES

* **AZ-1088:** module v8 structure and updates

### Features

* **AZ-1088:** module v8 structure and updates 55b61a5

### Miscellaneous Chores

* **deps:** update dependency opentofu to v1.8.3 049ce5e
* **deps:** update dependency opentofu to v1.8.4 a580aa3
* **deps:** update dependency opentofu to v1.8.6 3dd6d0e
* **deps:** update dependency opentofu to v1.8.8 2e10a40
* **deps:** update dependency opentofu to v1.9.0 975d818
* **deps:** update dependency pre-commit to v4 5ae4a61
* **deps:** update dependency pre-commit to v4.0.1 ee91983
* **deps:** update dependency pre-commit to v4.1.0 38fec91
* **deps:** update dependency tflint to v0.54.0 ffa3ece
* **deps:** update dependency tflint to v0.55.0 4966d2c
* **deps:** update dependency trivy to v0.56.0 1f74a88
* **deps:** update dependency trivy to v0.56.1 a3edce0
* **deps:** update dependency trivy to v0.56.2 51ca104
* **deps:** update dependency trivy to v0.57.1 d23c822
* **deps:** update dependency trivy to v0.58.1 8944efa
* **deps:** update dependency trivy to v0.58.2 fb70f05
* **deps:** update pre-commit hook alessandrojcm/commitlint-pre-commit-hook to v9.19.0 81dd0a3
* **deps:** update pre-commit hook alessandrojcm/commitlint-pre-commit-hook to v9.20.0 de95a0a
* **deps:** update pre-commit hook pre-commit/pre-commit-hooks to v5 6c78c6a
* **deps:** update pre-commit hook tofuutils/pre-commit-opentofu to v2.1.0 6ccc76f
* **deps:** update tools f6ca9c4
* **deps:** update tools 21349fc
* prepare for new examples structure 91c5b5d
* update examples structure e31eab6
* update tflint config for v0.55.0 9eab40b

## 7.1.0 (2024-10-03)

### Features

* use Claranet "azurecaf" provider 097d15e

### Documentation

* update README badge to use OpenTofu registry 1ebb562
* update README with `terraform-docs` v0.19.0 9caa989

### Miscellaneous Chores

* **deps:** update dependency opentofu to v1.7.3 b29d036
* **deps:** update dependency opentofu to v1.8.0 0c1effc
* **deps:** update dependency opentofu to v1.8.2 04eecfa
* **deps:** update dependency pre-commit to v3.8.0 5c8e535
* **deps:** update dependency terraform-docs to v0.19.0 cc50f80
* **deps:** update dependency tflint to v0.51.2 9771ee0
* **deps:** update dependency tflint to v0.52.0 708344b
* **deps:** update dependency tflint to v0.53.0 fa67eac
* **deps:** update dependency trivy to v0.53.0 3072168
* **deps:** update dependency trivy to v0.55.0 837a231
* **deps:** update dependency trivy to v0.55.1 badc7d5
* **deps:** update dependency trivy to v0.55.2 b4bf7dd
* **deps:** update pre-commit hook alessandrojcm/commitlint-pre-commit-hook to v9.17.0 5e770f5
* **deps:** update pre-commit hook alessandrojcm/commitlint-pre-commit-hook to v9.18.0 a1de109
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.92.2 20acc59
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.92.3 1aecd00
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.93.0 d8b26ec
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.94.0 297e7e4
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.94.1 74f36cf
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.94.2 9c47f67
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.94.3 bbe3304
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.95.0 78df36b
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.96.0 b0d9ad3
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.96.1 161f000
* **deps:** update terraform claranet/diagnostic-settings/azurerm to v7 4086f2b
* **deps:** update tools 95040a8

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
