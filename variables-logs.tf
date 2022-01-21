variable "diag_settings_name" {
  description = "Custom name for the diagnostic settings of Application Gateway."
  type        = string
  default     = ""
}

variable "logs_storage_retention" {
  description = "Retention in days for logs on Storage Account"
  type        = number
  default     = 30
}

variable "log_categories" {
  type        = list(string)
  default     = null
  description = "List of log categories to send"
}

variable "metric_categories" {
  type        = list(string)
  default     = null
  description = "List of metric categories to send"
}

variable "logs_destinations_ids" {
  type        = list(string)
  description = "List of destination resources IDs for logs diagnostic destination. Can be Storage Account, Log Analytics Workspace and Event Hub. No more than one of each can be set."
  default     = []
}

variable "log_destination_type" {
  type        = string
  description = "Log sent to Log Analytics can be sent to 'Dedicated' log tables or the legacy 'AzureDiagnostics'"
  default     = "Dedicated"
}
