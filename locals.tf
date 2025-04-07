locals {
  products_groups = flatten([
    for product_data in var.products : [
      for group in product_data.groups_names : {
        product = product_data.display_name
        group   = group
      }
    ]
  ])
}
