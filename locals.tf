locals {
  # Generate a default name
  name_prefix  = var.name_prefix != "" ? replace(var.name_prefix, "/[a-z0-9]$/", "$0-") : ""
  default_name = "${local.name_prefix}${var.stack}-${var.client_name}-${var.location_short}-${var.environment}-apim"

  diag_settings_name = var.diag_settings_name != "" ? var.diag_settings_name : join("-", [local.default_name, "diag-settings"])
}
