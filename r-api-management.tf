resource "azurerm_api_management" "apim" {
  name                = coalesce(var.custom_name, local.default_name)
  location            = var.location
  resource_group_name = var.resource_group_name

  publisher_name  = var.publisher_name
  publisher_email = var.publisher_email
  sku_name        = var.sku_name

  dynamic "additional_location" {
    for_each = toset(var.additional_location)
    content {
      location = additional_location.value
    }
  }

  dynamic "certificate" {
    for_each = var.certificate_configuration
    content {
      encoded_certificate  = lookup(certificate.value, "encoded_certificate")
      certificate_password = lookup(certificate.value, "certificate_password")
      store_name           = lookup(certificate.value, "store_name")
    }
  }

  identity {
    type = var.identity_type
  }

  dynamic "hostname_configuration" {
    for_each = coalescelist(
      var.management_hostname_configuration,
      var.portal_hostname_configuration,
      var.developer_portal_hostname_configuration,
      var.proxy_hostname_configuration,
      ["empty"]
    )[0] == "empty" ? [] : ["fake"]
    content {
      dynamic "management" {
        for_each = var.management_hostname_configuration
        content {
          host_name                    = lookup(management.value, "host_name")
          key_vault_id                 = lookup(management.value, "key_vault_id", null)
          certificate                  = lookup(management.value, "certificate", null)
          certificate_password         = lookup(management.value, "certificate_password", null)
          negotiate_client_certificate = lookup(management.value, "negotiate_client_certificate", false)
        }
      }
      dynamic "portal" {
        for_each = var.portal_hostname_configuration
        content {
          host_name                    = lookup(portal.value, "host_name")
          key_vault_id                 = lookup(portal.value, "key_vault_id", null)
          certificate                  = lookup(portal.value, "certificate", null)
          certificate_password         = lookup(portal.value, "certificate_password", null)
          negotiate_client_certificate = lookup(portal.value, "negotiate_client_certificate", false)
        }
      }
      dynamic "developer_portal" {
        for_each = var.developer_portal_hostname_configuration
        content {
          host_name                    = lookup(developer_portal.value, "host_name")
          key_vault_id                 = lookup(developer_portal.value, "key_vault_id", null)
          certificate                  = lookup(developer_portal.value, "certificate", null)
          certificate_password         = lookup(developer_portal.value, "certificate_password", null)
          negotiate_client_certificate = lookup(developer_portal.value, "negotiate_client_certificate", false)
        }
      }
      dynamic "proxy" {
        for_each = var.proxy_hostname_configuration
        content {
          host_name                    = lookup(proxy.value, "host_name")
          default_ssl_binding          = lookup(proxy.value, "default_ssl_binding", false)
          key_vault_id                 = lookup(proxy.value, "key_vault_id", null)
          certificate                  = lookup(proxy.value, "certificate", null)
          certificate_password         = lookup(proxy.value, "certificate_password", null)
          negotiate_client_certificate = lookup(proxy.value, "negotiate_client_certificate", false)
        }
      }
      dynamic "scm" {
        for_each = var.scm_hostname_configuration
        content {
          host_name                    = lookup(scm.value, "host_name")
          key_vault_id                 = lookup(scm.value, "key_vault_id", null)
          certificate                  = lookup(scm.value, "certificate", null)
          certificate_password         = lookup(scm.value, "certificate_password", null)
          negotiate_client_certificate = lookup(scm.value, "negotiate_client_certificate", false)
        }
      }

    }
  }

  notification_sender_email = var.notification_sender_email

  dynamic "policy" {
    for_each = var.policy_configuration
    content {
      xml_content = lookup(policy.value, "xml_content", null)
      xml_link    = lookup(policy.value, "xml_link", null)
    }
  }

  protocols {
    enable_http2 = var.enable_http2
  }

  dynamic "security" {
    for_each = var.security_configuration
    content {
      enable_backend_ssl30      = lookup(security.value, "enable_backend_ssl30", false)
      enable_backend_tls10      = lookup(security.value, "enable_backend_tls10", false)
      enable_backend_tls11      = lookup(security.value, "enable_backend_tls11", false)
      enable_frontend_ssl30     = lookup(security.value, "enable_frontend_ssl30", false)
      enable_frontend_tls10     = lookup(security.value, "enable_frontend_tls10", false)
      enable_frontend_tls11     = lookup(security.value, "enable_frontend_tls11", false)
      enable_triple_des_ciphers = lookup(security.value, "enable_triple_des_ciphers", false)
    }
  }

  sign_in {
    enabled = var.enable_sign_in
  }

  sign_up {
    enabled = var.enable_sign_up
    dynamic "terms_of_service" {
      for_each = var.terms_of_service_configuration
      content {
        consent_required = lookup(terms_of_service.value, "consent_required")
        enabled          = lookup(terms_of_service.value, "enabled")
        text             = lookup(terms_of_service.value, "text")
      }
    }
  }

  virtual_network_type = var.virtual_network_type

  dynamic "virtual_network_configuration" {
    for_each = toset(var.virtual_network_configuration)
    content {
      subnet_id = virtual_network_configuration.value
    }
  }

  tags = merge(local.default_tags, var.extra_tags)
}
