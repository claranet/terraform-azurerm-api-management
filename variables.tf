variable "client_name" {
  description = "Client name/account used in naming"
  type        = string
}

variable "environment" {
  description = "Project environment"
  type        = string
}

variable "stack" {
  description = "Project stack name"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure location for Eventhub."
  type        = string
}

variable "location_short" {
  description = "Short string for Azure location."
  type        = string
}

variable "sku_tier" {
  type        = string
  description = "APIM SKU. Valid values include: Developer, Basic, Standard, StandardV2 and Premium."
  default     = "Basic"

  validation {
    condition     = contains(["Developer", "Basic", "Standard", "StandardV2", "Premium"], var.sku_tier)
    error_message = "Invalid SKU tier. Valid values include: Developer, Basic, Standard, StandardV2 and Premium."
  }
}

variable "sku_capacity" {
  type        = number
  description = "APIM SKU capacity."
  default     = 1
}

variable "publisher_name" {
  type        = string
  description = "The name of publisher/company."
}

variable "publisher_email" {
  type        = string
  description = "The email of publisher/company."
}

variable "additional_location" {
  type = list(object({
    location             = string
    capacity             = optional(number)
    zones                = optional(list(number), [1, 2, 3])
    public_ip_address_id = optional(string)
    subnet_id            = optional(string)
  }))
  description = "List of the Azure Region in which the API Management Service should be expanded to."
  default     = []
  nullable    = false
}

variable "zones" {
  type        = list(number)
  description = "(Optional) Specifies a list of Availability Zones in which this API Management service should be located. Changing this forces a new API Management service to be created. Supported in Premium Tier."
  default     = [1, 2, 3]
}

variable "certificate_configuration" {
  type = list(object({
    encoded_certificate  = string
    certificate_password = optional(string)
    store_name           = string
  }))
  description = "List of certificate configurations."
  default     = []
  nullable    = false

  validation {
    condition     = alltrue([for cert in var.certificate_configuration : contains(["Root", "CertificateAuthority"], cert.store_name)])
    error_message = "Possible values are `CertificateAuthority` and `Root` for 'store_name' attribute."
  }
}

variable "client_certificate_enabled" {
  type        = bool
  description = "(Optional) Enforce a client certificate to be presented on each request to the gateway? This is only supported when SKU type is `Consumption`."
  default     = false
}

variable "gateway_disabled" {
  type        = bool
  description = "(Optional) Disable the gateway in main region? This is only supported when `additional_location` is set."
  default     = false
}

variable "min_api_version" {
  type        = string
  description = "(Optional) The version which the control plane API calls to API Management service are limited with version equal to or newer than."
  default     = null
}

variable "enable_http2" {
  type        = bool
  description = "Should HTTP/2 be supported by the API Management Service?"
  default     = false
}

## hostname_configurations

variable "management_hostname_configuration" {
  type = list(object({
    host_name                    = string
    key_vault_id                 = optional(string)
    certificate                  = optional(string)
    certificate_password         = optional(string)
    negotiate_client_certificate = optional(bool, false)
  }))
  description = "List of management hostname configurations."
  default     = []
  nullable    = false
}

variable "portal_hostname_configuration" {
  type = list(object({
    host_name                    = string
    key_vault_id                 = optional(string)
    certificate                  = optional(string)
    certificate_password         = optional(string)
    negotiate_client_certificate = optional(bool, false)
  }))
  description = "Legacy Portal hostname configurations."
  default     = []
  nullable    = false
}

variable "developer_portal_hostname_configuration" {
  type = list(object({
    host_name                    = string
    key_vault_id                 = optional(string)
    certificate                  = optional(string)
    certificate_password         = optional(string)
    negotiate_client_certificate = optional(bool, false)
  }))
  description = "Developer Portal hostname configurations."
  default     = []
  nullable    = false
}

variable "proxy_hostname_configuration" {
  type = list(object({
    host_name                    = string
    key_vault_id                 = optional(string)
    certificate                  = optional(string)
    certificate_password         = optional(string)
    negotiate_client_certificate = optional(bool, false)
  }))
  description = "List of proxy hostname configurations."
  default     = []
  nullable    = false
}

variable "scm_hostname_configuration" {
  type = list(object({
    host_name                    = string
    key_vault_id                 = optional(string)
    certificate                  = optional(string)
    certificate_password         = optional(string)
    negotiate_client_certificate = optional(bool, false)
  }))
  description = "List of SCM hostname configurations."
  default     = []
  nullable    = false
}

##

variable "notification_sender_email" {
  type        = string
  description = "Email address from which the notification will be sent."
  default     = null
}

variable "policy_configuration" {
  type = list(object({
    name        = optional(string, "default")
    xml_content = optional(string)
    xml_link    = optional(string)
  }))
  description = "Policies configurations."
  default     = []
  nullable    = false
}

variable "sign_in_enabled" {
  type        = bool
  description = "Should anonymous users be redirected to the sign in page?"
  default     = false
}

variable "sign_up_enabled" {
  type        = bool
  description = "Can users sign up on the development portal?"
  default     = false
}

variable "terms_of_service_configuration" {
  type = list(object({
    consent_required = optional(bool, false)
    enabled          = optional(bool, false)
    text             = optional(string, "")
  }))
  description = "Terms of service configurations."
  default     = []
  nullable    = false
}

variable "security_configuration" {
  type = object({
    enable_backend_ssl30  = optional(bool, false)
    enable_backend_tls10  = optional(bool, false)
    enable_backend_tls11  = optional(bool, false)
    enable_frontend_ssl30 = optional(bool, false)
    enable_frontend_tls10 = optional(bool, false)
    enable_frontend_tls11 = optional(bool, false)

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
  description = "Security configuration block."
  default     = {}
}

### NETWORKING

variable "virtual_network_type" {
  type        = string
  description = "The type of virtual network you want to use, valid values include: None, External, Internal."
  default     = null
}

variable "virtual_network_configuration" {
  type        = list(string)
  description = "The id(s) of the subnet(s) that will be used for the API Management. Required when virtual_network_type is External or Internal"
  default     = []
}

variable "nsg_name" {
  type        = string
  description = "NSG name of the subnet hosting the APIM to add the rule to allow management if the APIM is private"
  default     = null
}

variable "nsg_rg_name" {
  type        = string
  description = "Name of the RG hosting the NSG if it's different from the one hosting the APIM"
  default     = null
}

variable "create_management_rule" {
  type        = bool
  description = "Whether to create the NSG rule for the management port of the APIM. If true, nsg_name variable must be set"
  default     = false
}

variable "management_nsg_rule_priority" {
  type        = number
  description = "Priority of the NSG rule created for the management port of the APIM"
  default     = 101
}

### IDENTITY

variable "identity_type" {
  description = "Type of Managed Service Identity that should be configured on this API Management Service"
  type        = string
  default     = "SystemAssigned"
}

variable "identity_ids" {
  description = "A list of IDs for User Assigned Managed Identity resources to be assigned. This is required when type is set to UserAssigned or SystemAssigned, UserAssigned."
  type        = list(string)
  default     = []
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

variable "products" {
  description = "List of products to create."
  type        = list(string)
  default     = []
}

variable "create_product_group_and_relationships" {
  description = "Create local APIM groups with name identical to products and create a relationship between groups and products"
  type        = bool
  default     = false
}
