resource "azurerm_api_management_backend" "main" {
  for_each = { for backend in var.backends : backend.name => backend }

  resource_group_name = var.resource_group_name
  api_management_name = azurerm_api_management.main.name

  name        = each.value.name
  protocol    = each.value.protocol
  url         = each.value.url
  description = each.value.description

  resource_id = each.value.resource_id
  title       = each.value.title

  dynamic "credentials" {
    for_each = each.value.credentials[*]
    content {
      dynamic "authorization" {
        for_each = credentials.value.authorization[*]
        content {
          parameter = authorization.value.parameter
          scheme    = authorization.value.scheme
        }
      }
      certificate = credentials.value.certificate
      header      = credentials.value.header
      query       = credentials.value.query
    }
  }

  dynamic "proxy" {
    for_each = each.value.proxy[*]
    content {
      url      = proxy.value.url
      username = proxy.value.username
      password = proxy.value.password
    }
  }

  dynamic "tls" {
    for_each = each.value.tls[*]
    content {
      validate_certificate_chain = tls.value.validate_certificate_chain
      validate_certificate_name  = tls.value.validate_certificate_name
    }
  }
}
