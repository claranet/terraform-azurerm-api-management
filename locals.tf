locals {
  products_groups = flatten([
    for product_data in var.products : [
      for group in product_data.groups_names : {
        product = product_data.display_name
        group   = group
      }
    ]
  ])

  products_policies = {
    for product_data in var.products :
    product_data.display_name => {
      link = try(startswith(product_data.policy, "http"), false) ? product_data.policy : null
      xml  = try(startswith(product_data.policy, "<policies"), false) ? product_data.policy : null
    } if product_data.policy != null
  }
}
