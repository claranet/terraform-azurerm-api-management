variable "location" {
  description = "Azure location."
  type        = string
}

variable "location_short" {
  description = "Short string for Azure location."
  type        = string
}

variable "client_name" {
  description = "Client name/account used in naming."
  type        = string
}

variable "environment" {
  description = "Project environment."
  type        = string
}

variable "stack" {
  description = "Project stack name."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name."
  type        = string
}

variable "sku_tier" {
  description = "APIM SKU. Valid values include: Developer, Basic, Standard, StandardV2 and Premium."
  type        = string
  default     = "Premium"

  validation {
    condition     = contains(["Developer", "Basic", "Standard", "StandardV2", "Premium"], var.sku_tier)
    error_message = "Invalid SKU tier. Valid values include: Developer, Basic, Standard, StandardV2 and Premium."
  }
}

variable "sku_capacity" {
  description = "APIM SKU capacity."
  type        = number
  default     = 1
}

variable "publisher_name" {
  description = "The name of publisher/company."
  type        = string
}

variable "publisher_email" {
  description = "The email of publisher/company."
  type        = string
}

variable "additional_locations" {
  description = "List of Azure Regions in which the API Management service should be expanded to."
  type = list(object({
    location             = string
    capacity             = optional(number)
    zones                = optional(list(number), [1, 2, 3])
    public_ip_address_id = optional(string)
    subnet_id            = optional(string)
  }))
  default  = []
  nullable = false
}

variable "zones" {
  description = "Specifies a list of Availability Zones in which this API Management service should be located. Changing this forces a new API Management service to be created. Supported in Premium Tier."
  type        = list(number)
  default     = [1, 2, 3]
}

variable "certificate_configurations" {
  description = "List of certificate configurations."
  type = list(object({
    encoded_certificate  = string
    certificate_password = optional(string)
    store_name           = string
  }))
  default  = []
  nullable = false

  validation {
    condition     = alltrue([for cert in var.certificate_configurations : contains(["Root", "CertificateAuthority"], cert.store_name)])
    error_message = "Possible values are `CertificateAuthority` and `Root` for 'store_name' attribute."
  }
}

variable "client_certificate_enabled" {
  description = "(Optional) Enforce a client certificate to be presented on each request to the gateway? This is only supported when SKU type is `Consumption`."
  type        = bool
  default     = false
}

variable "gateway_enabled" {
  description = "Whether enable or disable the gateway in main region? Can be disabled only when `additional_locations` is set."
  type        = bool
  default     = true
}

variable "min_api_version" {
  description = "(Optional) The version which the control plane API calls to API Management service are limited with version equal to or newer than."
  type        = string
  default     = null
}

variable "http2_enabled" {
  description = "Should HTTP/2 be supported by the API Management Service?"
  type        = bool
  default     = false
}

## hostname_configurations

variable "management_hostname_configurations" {
  description = "List of management hostname configurations."
  type = list(object({
    host_name                    = string
    key_vault_id                 = optional(string)
    certificate                  = optional(string)
    certificate_password         = optional(string)
    negotiate_client_certificate = optional(bool, false)
  }))
  default  = []
  nullable = false
}

variable "portal_hostname_configurations" {
  description = "Legacy Portal hostname configurations."
  type = list(object({
    host_name                    = string
    key_vault_id                 = optional(string)
    certificate                  = optional(string)
    certificate_password         = optional(string)
    negotiate_client_certificate = optional(bool, false)
  }))
  default  = []
  nullable = false
}

variable "developer_portal_hostname_configurations" {
  description = "Developer Portal hostname configurations."
  type = list(object({
    host_name                    = string
    key_vault_id                 = optional(string)
    certificate                  = optional(string)
    certificate_password         = optional(string)
    negotiate_client_certificate = optional(bool, false)
  }))
  default  = []
  nullable = false
}

variable "proxy_hostname_configurations" {
  description = "List of proxy hostname configurations."
  type = list(object({
    host_name                    = string
    key_vault_id                 = optional(string)
    certificate                  = optional(string)
    certificate_password         = optional(string)
    default_ssl_binding          = optional(bool, false)
    negotiate_client_certificate = optional(bool, false)
  }))
  default  = []
  nullable = false
}

variable "scm_hostname_configurations" {
  description = "List of SCM hostname configurations."
  type = list(object({
    host_name                    = string
    key_vault_id                 = optional(string)
    certificate                  = optional(string)
    certificate_password         = optional(string)
    negotiate_client_certificate = optional(bool, false)
  }))
  default  = []
  nullable = false
}

##

variable "notification_sender_email" {
  description = "Email address from which the notification will be sent."
  type        = string
  default     = null
}

variable "policy_configurations" {
  description = "Policies configurations."
  type = list(object({
    name        = optional(string, "default")
    xml_content = optional(string)
    xml_link    = optional(string)
  }))
  default  = []
  nullable = false
}

variable "sign_in_enabled" {
  description = "Should anonymous users be redirected to the sign in page?"
  type        = bool
  default     = false
}

variable "sign_up_enabled" {
  description = "Can users sign up on the development portal?"
  type        = bool
  default     = false
}

variable "terms_of_service_configuration" {
  description = "Terms of service configuration."
  type = object({
    consent_required = optional(bool, false)
    enabled          = optional(bool, false)
    text             = optional(string, "")
  })
  default  = {}
  nullable = false
}

variable "security_configuration" {
  description = "Security configuration block."
  type = object({
    backend_ssl30_enabled  = optional(bool, false)
    backend_tls10_enabled  = optional(bool, false)
    backend_tls11_enabled  = optional(bool, false)
    frontend_ssl30_enabled = optional(bool, false)
    frontend_tls10_enabled = optional(bool, false)
    frontend_tls11_enabled = optional(bool, false)

    tls_ecdhe_ecdsa_with_aes128_cbc_sha_ciphers_enabled = optional(bool, false)
    tls_ecdhe_ecdsa_with_aes256_cbc_sha_ciphers_enabled = optional(bool, false)
    tls_ecdhe_rsa_with_aes128_cbc_sha_ciphers_enabled   = optional(bool, false)
    tls_ecdhe_rsa_with_aes256_cbc_sha_ciphers_enabled   = optional(bool, false)
    tls_rsa_with_aes128_cbc_sha256_ciphers_enabled      = optional(bool, false)
    tls_rsa_with_aes128_cbc_sha_ciphers_enabled         = optional(bool, false)
    tls_rsa_with_aes128_gcm_sha256_ciphers_enabled      = optional(bool, false)
    tls_rsa_with_aes256_cbc_sha256_ciphers_enabled      = optional(bool, false)
    tls_rsa_with_aes256_cbc_sha_ciphers_enabled         = optional(bool, false)

    triple_des_ciphers_enabled = optional(bool, false)
  })
  default = null
}

### NETWORKING

variable "virtual_network_type" {
  description = "The type of Virtual Network you want to use, valid values include: `None`, `External` and `Internal`. Defaults to `None`."
  type        = string
  default     = "None"
}

variable "subnet_id" {
  description = "ID of the Subnet that will be used for the API Management in current location. Required when `var.virtual_network_type` is `External` or `Internal`."
  type        = string
  default     = null
}

variable "nsg_name" {
  description = "NSG name of the subnet hosting the APIM to add the rule to allow management if the APIM is private."
  type        = string
  default     = null
}

variable "nsg_rg_name" {
  description = "Name of the RG hosting the NSG if it's different from the one hosting the APIM."
  type        = string
  default     = null
}

variable "create_management_rule" {
  description = "Whether to create the NSG rule for the management port of the APIM. If true, nsg_name variable must be set."
  type        = bool
  default     = false
}

variable "management_nsg_rule_priority" {
  description = "Priority of the NSG rule created for the management port of the APIM."
  type        = number
  default     = 101
}

### IDENTITY

variable "identity_type" {
  description = "Type of Managed Service Identity that should be configured on this API Management Service."
  type        = string
  default     = "SystemAssigned"
}

variable "identity_ids" {
  description = "A list of IDs for User Assigned Managed Identity resources to be assigned. This is required when type is set to `UserAssigned` or `SystemAssigned, UserAssigned`."
  type        = list(string)
  default     = null
}

variable "named_values" {
  description = "Named values configurations."
  type = list(object({
    name         = string
    display_name = optional(string)
    value        = string
    secret       = optional(bool, false)
  }))
  default  = []
  nullable = false
}

variable "groups" {
  description = "List of Groups to create with options."
  type = list(object({
    name         = optional(string)
    display_name = string
    description  = optional(string)
    type         = optional(string)
    external_id  = optional(string)
  }))
  default  = []
  nullable = false
}

variable "products" {
  description = "List of Products to create with options and Groups to associate to."
  type = list(object({
    product_id            = optional(string)
    display_name          = string
    description           = optional(string)
    terms                 = optional(string)
    subscription_required = optional(bool, true)
    approval_required     = optional(bool, false)
    published             = optional(bool, true)
    subscriptions_limit   = optional(number, 1)
    groups_names          = optional(list(string), [])
    policy                = optional(string)
  }))
  default  = []
  nullable = false
}

variable "backends" {
  description = "List of backend configurations for the API Management service."
  type = list(object({
    name        = string
    protocol    = string
    url         = string
    description = optional(string)
    resource_id = optional(string)
    title       = optional(string)

    credentials = optional(object({
      authorization = optional(object({
        parameter = string
        scheme    = string
      }))
      certificate = optional(list(string))
      header      = optional(map(string))
      query       = optional(map(string))
    }))

    proxy = optional(object({
      url      = string
      username = string
      password = string
    }))

    tls = optional(object({
      validate_certificate_chain = optional(bool)
      validate_certificate_name  = optional(bool)
    }))
  }))
  default  = []
  nullable = false
}
