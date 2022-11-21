resource "azurerm_api_management" "apim" {
  name                = local.apim_name
  location            = var.location
  resource_group_name = var.resource_group_name

  publisher_name  = var.publisher_name
  publisher_email = var.publisher_email
  sku_name        = var.sku_name
  zones           = var.zones

  dynamic "additional_location" {
    for_each = var.additional_location
    content {
      location = lookup(additional_location.value, "location", null)
      capacity = lookup(additional_location.value, "capacity", null)
      zones    = lookup(additional_location.value, "zones", [1, 2, 3])
      dynamic "virtual_network_configuration" {
        for_each = lookup(additional_location.value, "subnet_id", null) == null ? [] : [1]
        content {
          subnet_id = additional_location.value.subnet_id
        }
      }
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

  client_certificate_enabled = var.client_certificate_enabled
  gateway_disabled           = var.gateway_disabled
  min_api_version            = var.min_api_version

  identity {
    type         = var.identity_type
    identity_ids = replace(var.identity_type, "UserAssigned", "") == var.identity_type ? null : var.identity_ids
  }

  dynamic "hostname_configuration" {
    for_each = length(concat(
      var.management_hostname_configuration,
      var.portal_hostname_configuration,
      var.developer_portal_hostname_configuration,
      var.proxy_hostname_configuration,
    )) == 0 ? [] : ["fake"]

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
      enable_backend_ssl30  = lookup(security.value, "enable_backend_ssl30", false)
      enable_backend_tls10  = lookup(security.value, "enable_backend_tls10", false)
      enable_backend_tls11  = lookup(security.value, "enable_backend_tls11", false)
      enable_frontend_ssl30 = lookup(security.value, "enable_frontend_ssl30", false)
      enable_frontend_tls10 = lookup(security.value, "enable_frontend_tls10", false)
      enable_frontend_tls11 = lookup(security.value, "enable_frontend_tls11", false)

      tls_ecdhe_ecdsa_with_aes128_cbc_sha_ciphers_enabled = lookup(security.value, "tls_ecdhe_ecdsa_with_aes128_cbc_sha_ciphers_enabled", false)
      tls_ecdhe_ecdsa_with_aes256_cbc_sha_ciphers_enabled = lookup(security.value, "tls_ecdhe_ecdsa_with_aes256_cbc_sha_ciphers_enabled", false)
      tls_ecdhe_rsa_with_aes128_cbc_sha_ciphers_enabled   = lookup(security.value, "tls_ecdheRsa_with_aes128_cbc_sha_ciphers_enabled", lookup(security.value, "tls_ecdhe_rsa_with_aes128_cbc_sha_ciphers_enabled", false))
      tls_ecdhe_rsa_with_aes256_cbc_sha_ciphers_enabled   = lookup(security.value, "tls_ecdheRsa_with_aes256_cbc_sha_ciphers_enabled", lookup(security.value, "tls_ecdhe_rsa_with_aes256_cbc_sha_ciphers_enabled", false))
      tls_rsa_with_aes128_cbc_sha256_ciphers_enabled      = lookup(security.value, "tls_rsa_with_aes128_cbc_sha256_ciphers_enabled", false)
      tls_rsa_with_aes128_cbc_sha_ciphers_enabled         = lookup(security.value, "tls_rsa_with_aes128_cbc_sha_ciphers_enabled", false)
      tls_rsa_with_aes128_gcm_sha256_ciphers_enabled      = lookup(security.value, "tls_rsa_with_aes128_gcm_sha256_ciphers_enabled", false)
      tls_rsa_with_aes256_cbc_sha256_ciphers_enabled      = lookup(security.value, "tls_rsa_with_aes256_cbc_sha256_ciphers_enabled", false)
      tls_rsa_with_aes256_cbc_sha_ciphers_enabled         = lookup(security.value, "tls_rsa_with_aes256_cbc_sha_ciphers_enabled", false)

      triple_des_ciphers_enabled = lookup(security.value, "triple_des_ciphers_enabled ", false)
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

  depends_on = [azurerm_network_security_rule.management_apim]
}
