resource "azurerm_api_management" "main" {
  name                = local.name
  location            = var.location
  resource_group_name = var.resource_group_name

  publisher_name  = var.publisher_name
  publisher_email = var.publisher_email
  sku_name        = "${var.sku_tier}_${var.sku_capacity}"
  zones           = var.zones

  dynamic "additional_location" {
    for_each = var.additional_locations
    content {
      location             = additional_location.value.location
      capacity             = additional_location.value.capacity
      zones                = additional_location.value.zones
      public_ip_address_id = additional_location.value.public_ip_address_id

      dynamic "virtual_network_configuration" {
        for_each = var.virtual_network_type != "None" ? additional_location.value.subnet_id[*] : []
        content {
          subnet_id = virtual_network_configuration.value
        }
      }
    }
  }

  dynamic "certificate" {
    for_each = var.certificate_configurations
    content {
      encoded_certificate  = certificate.value.encoded_certificate
      certificate_password = certificate.value.certificate_password
      store_name           = certificate.value.store_name
    }
  }

  client_certificate_enabled = var.client_certificate_enabled
  gateway_disabled           = !var.gateway_enabled
  min_api_version            = var.min_api_version

  identity {
    type         = var.identity_type
    identity_ids = endswith(var.identity_type, "UserAssigned") ? var.identity_ids : null
  }

  dynamic "hostname_configuration" {
    for_each = length(concat(
      var.management_hostname_configurations,
      var.portal_hostname_configurations,
      var.developer_portal_hostname_configurations,
      var.proxy_hostname_configurations,
      var.scm_hostname_configurations,
    )) > 0 ? [0] : []

    content {
      dynamic "management" {
        for_each = var.management_hostname_configurations
        content {
          host_name                    = management.value.host_name
          key_vault_certificate_id     = management.value.key_vault_certificate_id
          certificate                  = management.value.certificate
          certificate_password         = management.value.certificate_password
          negotiate_client_certificate = management.value.negotiate_client_certificate
        }
      }

      dynamic "portal" {
        for_each = var.portal_hostname_configurations
        content {
          host_name                    = portal.value.host_name
          key_vault_certificate_id     = portal.value.key_vault_certificate_id
          certificate                  = portal.value.certificate
          certificate_password         = portal.value.certificate_password
          negotiate_client_certificate = portal.value.negotiate_client_certificate
        }
      }

      dynamic "developer_portal" {
        for_each = var.developer_portal_hostname_configurations
        content {
          host_name                    = developer_portal.value.host_name
          key_vault_certificate_id     = developer_portal.value.key_vault_certificate_id
          certificate                  = developer_portal.value.certificate
          certificate_password         = developer_portal.value.certificate_password
          negotiate_client_certificate = developer_portal.value.negotiate_client_certificate
        }
      }

      dynamic "proxy" {
        for_each = var.proxy_hostname_configurations
        content {
          host_name                    = proxy.value.host_name
          default_ssl_binding          = proxy.value.default_ssl_binding
          key_vault_certificate_id     = proxy.value.key_vault_certificate_id
          certificate                  = proxy.value.certificate
          certificate_password         = proxy.value.certificate_password
          negotiate_client_certificate = proxy.value.negotiate_client_certificate
        }
      }

      dynamic "scm" {
        for_each = var.scm_hostname_configurations
        content {
          host_name                    = scm.value.host_name
          key_vault_certificate_id     = scm.value.key_vault_certificate_id
          certificate                  = scm.value.certificate
          certificate_password         = scm.value.certificate_password
          negotiate_client_certificate = scm.value.negotiate_client_certificate
        }
      }
    }
  }

  notification_sender_email = var.notification_sender_email

  protocols {
    http2_enabled = var.http2_enabled
  }

  dynamic "security" {
    for_each = var.security_configuration[*]
    content {
      backend_ssl30_enabled  = security.value.backend_ssl30_enabled
      backend_tls10_enabled  = security.value.backend_tls10_enabled
      backend_tls11_enabled  = security.value.backend_tls11_enabled
      frontend_ssl30_enabled = security.value.frontend_ssl30_enabled
      frontend_tls10_enabled = security.value.frontend_tls10_enabled
      frontend_tls11_enabled = security.value.frontend_tls11_enabled

      tls_ecdhe_ecdsa_with_aes128_cbc_sha_ciphers_enabled = security.value.tls_ecdhe_ecdsa_with_aes128_cbc_sha_ciphers_enabled
      tls_ecdhe_ecdsa_with_aes256_cbc_sha_ciphers_enabled = security.value.tls_ecdhe_ecdsa_with_aes256_cbc_sha_ciphers_enabled
      tls_ecdhe_rsa_with_aes128_cbc_sha_ciphers_enabled   = security.value.tls_ecdhe_rsa_with_aes128_cbc_sha_ciphers_enabled
      tls_ecdhe_rsa_with_aes256_cbc_sha_ciphers_enabled   = security.value.tls_ecdhe_rsa_with_aes256_cbc_sha_ciphers_enabled
      tls_rsa_with_aes128_cbc_sha256_ciphers_enabled      = security.value.tls_rsa_with_aes128_cbc_sha256_ciphers_enabled
      tls_rsa_with_aes128_cbc_sha_ciphers_enabled         = security.value.tls_rsa_with_aes128_cbc_sha_ciphers_enabled
      tls_rsa_with_aes128_gcm_sha256_ciphers_enabled      = security.value.tls_rsa_with_aes128_gcm_sha256_ciphers_enabled
      tls_rsa_with_aes256_cbc_sha256_ciphers_enabled      = security.value.tls_rsa_with_aes256_cbc_sha256_ciphers_enabled
      tls_rsa_with_aes256_cbc_sha_ciphers_enabled         = security.value.tls_rsa_with_aes256_cbc_sha_ciphers_enabled

      triple_des_ciphers_enabled = security.value.triple_des_ciphers_enabled
    }
  }

  dynamic "sign_in" {
    for_each = var.sign_in_enabled ? [0] : []
    content {
      enabled = true
    }
  }

  dynamic "sign_up" {
    for_each = var.sign_up_enabled ? [0] : []
    content {
      enabled = true
      terms_of_service {
        consent_required = var.terms_of_service_configuration.consent_required
        enabled          = var.terms_of_service_configuration.enabled
        text             = var.terms_of_service_configuration.text
      }
    }
  }

  virtual_network_type = var.virtual_network_type

  dynamic "virtual_network_configuration" {
    for_each = var.virtual_network_type != "None" ? var.subnet_id[*] : []
    content {
      subnet_id = virtual_network_configuration.value
    }
  }

  tags = merge(local.default_tags, var.extra_tags)

  lifecycle {
    precondition {
      condition     = contains(["Premium", "PremiumV2"], var.sku_tier) || (var.sku_tier != "Premium" && var.sku_tier != "PremiumV2" && alltrue([for l in var.additional_locations : length(l.zones) == 0]))
      error_message = "Zones are only supported in the Premium and PremiumV2 SKU tiers."
    }
    precondition {
      condition     = contains(["Premium", "PremiumV2"], var.sku_tier) || (var.sku_tier == "Developer" && var.virtual_network_type != "None") || (!contains(["Premium", "PremiumV2", "Developer"], var.sku_tier) && alltrue([for l in var.additional_locations : l.public_ip_address_id == null]))
      error_message = "Custom public IPs are only supported on the Premium and Developer tiers when deployed in a virtual network."
    }
  }
}

moved {
  from = azurerm_api_management.apim
  to   = azurerm_api_management.main
}
