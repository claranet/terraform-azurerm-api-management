variable "client_name" {
  description = "Client name/account used in naming"
  type        = string
}

variable "name_prefix" {
  description = "Optional prefix for Network Security Group name"
  type        = string
  default     = ""
}

variable "custom_name" {
  description = "Custom API Management name, generated if not set"
  default     = ""
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

variable "extra_tags" {
  description = "Extra tags to add"
  type        = map(string)
  default     = {}
}

variable "sku_name" {
  type        = string
  description = "String consisting of two parts separated by an underscore. The fist part is the name, valid values include: Developer, Basic, Standard and Premium. The second part is the capacity"
  default     = "Basic_1"
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
  type        = list(string)
  description = "The name of the Azure Region in which the API Management Service should be expanded to."
  default     = []
}

variable "certificate_configuration" {
  type        = list(map(string))
  description = "List of certificate configurations"
  default     = []
}

variable "enable_http2" {
  type        = bool
  description = "Should HTTP/2 be supported by the API Management Service?"
  default     = false
}

variable "management_hostname_configuration" {
  type        = list(map(string))
  description = "List of management hostname configurations"
  default     = []
}

variable "scm_hostname_configuration" {
  type        = list(map(string))
  description = "List of scm hostname configurations"
  default     = []
}

variable "proxy_hostname_configuration" {
  type        = list(map(string))
  description = "List of proxy hostname configurations"
  default     = []
}

variable "portal_hostname_configuration" {
  type        = list(map(string))
  description = "List of portal hostname configurations"
  default     = []
}

variable "notification_sender_email" {
  type        = string
  description = "Email address from which the notification will be sent"
  default     = null
}

variable "policy_configuration" {
  type        = map(string)
  description = "Map of policy configuration"
  default     = {}
}

variable "enable_sign_in" {
  type        = bool
  description = "Should anonymous users be redirected to the sign in page?"
  default     = false
}

variable "enable_sign_up" {
  type        = bool
  description = "Can users sign up on the development portal?"
  default     = false
}

variable "terms_of_service_configuration" {
  type        = map(string)
  description = "Map of terms of service configuration"
  default     = {}
}

variable "security_configuration" {
  type        = map(string)
  description = "Map of security configuration"
  default     = {}
}
