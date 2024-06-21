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
  description = "Name of the resource group."
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
  description = "APIM SKU. Valid values include: Developer, Basic, Standard, StandardV2 and Premium."
  type        = string
  default     = "Basic"

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

variable "additional_location" {
  description = "List of the Azure Region in which the API Management Service should be expanded to."
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
  description = "(Optional) Specifies a list of Availability Zones in which this API Management service should be located. Changing this forces a new API Management service to be created. Supported in Premium Tier."
  type        = list(number)
  default     = [1, 2, 3]
}

variable "certificate_configuration" {
  description = "List of certificate configurations."
  type = list(object({
    encoded_certificate  = string
    certificate_password = optional(string)
    store_name           = string
  }))
  default  = []
  nullable = false

  validation {
    condition     = alltrue([for cert in var.certificate_configuration : contains(["Root", "CertificateAuthority"], cert.store_name)])
    error_message = "Possible values are `CertificateAuthority` and `Root` for 'store_name' attribute."
  }
}

variable "client_certificate_enabled" {
  description = "(Optional) Enforce a client certificate to be presented on each request to the gateway? This is only supported when SKU type is `Consumption`."
  type        = bool
  default     = false
}

variable "gateway_disabled" {
  description = "(Optional) Disable the gateway in main region? This is only supported when `additional_location` is set."
  type        = bool
  default     = false
}

variable "min_api_version" {
  description = "(Optional) The version which the control plane API calls to API Management service are limited with version equal to or newer than."
  type        = string
  default     = null
}

variable "enable_http2" {
  description = "Should HTTP/2 be supported by the API Management Service?"
  type        = bool
  default     = false
}

## hostname_configurations

variable "management_hostname_configuration" {
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

variable "portal_hostname_configuration" {
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

variable "developer_portal_hostname_configuration" {
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

variable "proxy_hostname_configuration" {
  description = "List of proxy hostname configurations."
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

variable "scm_hostname_configuration" {
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

variable "policy_configuration" {
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
  description = "Terms of service configurations."
  type = list(object({
    consent_required = optional(bool, false)
    enabled          = optional(bool, false)
    text             = optional(string, "")
  }))
  default  = []
  nullable = false
}

variable "security_configuration" {
  description = "Security configuration block."
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
  default = {}
}

### NETWORKING

variable "virtual_network_type" {
  description = "The type of virtual network you want to use, valid values include: None, External, Internal."
  type        = string
  default     = null
}

variable "virtual_network_configuration" {
  description = "The id(s) of the subnet(s) that will be used for the API Management. Required when virtual_network_type is External or Internal"
  type        = list(string)
  default     = []
}

variable "nsg_name" {
  description = "NSG name of the subnet hosting the APIM to add the rule to allow management if the APIM is private"
  type        = string
  default     = null
}

variable "nsg_rg_name" {
  description = "Name of the RG hosting the NSG if it's different from the one hosting the APIM"
  type        = string
  default     = null
}

variable "create_management_rule" {
  description = "Whether to create the NSG rule for the management port of the APIM. If true, nsg_name variable must be set"
  type        = bool
  default     = false
}

variable "management_nsg_rule_priority" {
  description = "Priority of the NSG rule created for the management port of the APIM"
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
  description = "Create local APIM groups with name identical to products and create a relationship between groups and products."
  type        = bool
  default     = false
}
