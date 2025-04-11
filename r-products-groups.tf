resource "azurerm_api_management_group" "main" {
  for_each = { for g in var.groups : g.display_name => g }

  resource_group_name = var.resource_group_name
  api_management_name = azurerm_api_management.main.name

  name         = coalesce(each.value.name, lower(replace(each.key, " ", "-")))
  display_name = each.key

  description = each.value.description
  type        = each.value.type
  external_id = each.value.external_id
}

resource "azurerm_api_management_product" "main" {
  for_each = { for p in var.products : p.display_name => p }

  resource_group_name = var.resource_group_name
  api_management_name = azurerm_api_management.main.name

  product_id = coalesce(each.value.product_id, lower(replace(replace(each.key, " ", "-"), "&", "-")))

  display_name          = each.key
  description           = each.value.description
  terms                 = each.value.terms
  subscription_required = each.value.subscription_required
  approval_required     = each.value.approval_required
  published             = each.value.published
  subscriptions_limit   = each.value.subscriptions_limit

  lifecycle {
    precondition {
      condition     = alltrue([for p in var.products : !p.approval_required || (p.approval_required && p.subscription_required)])
      error_message = "`var.products.approval_required` can only be set when `subscription_required` is set to true."
    }
    precondition {
      condition     = alltrue([for p in var.products : !p.approval_required || (p.approval_required && p.subscriptions_limit > 0)])
      error_message = "`var.products.subscriptions_limit` must be > 0 when `approval_required` is set to true."
    }
    precondition {
      condition     = alltrue([for p in var.products : !p.subscription_required || (p.subscription_required && p.subscriptions_limit > 0)])
      error_message = "`var.products.subscriptions_limit` can only be set when `subscription_required` is set to true."
    }
  }
}

resource "azurerm_api_management_product_group" "main" {
  for_each = { for p in local.products_groups : "${p.product}_${p.group}" => p }

  product_id = azurerm_api_management_product.main[each.value.product].product_id

  resource_group_name = var.resource_group_name
  api_management_name = azurerm_api_management.main.name

  # Associated groups can be user created or Azure built-ins
  group_name = try(azurerm_api_management_group.main[each.value.group].name, lower(each.value.group))
}

moved {
  from = azurerm_api_management_group.group
  to   = azurerm_api_management_group.main
}
moved {
  from = azurerm_api_management_product.product
  to   = azurerm_api_management_product.main
}
moved {
  from = azurerm_api_management_product_group.product_group
  to   = azurerm_api_management_product_group.main
}
