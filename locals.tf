locals {
  # Generate a default name
  default_name = "${var.stack}-${var.client_name}-${var.location_short}-${var.environment}-apim"

  # Tags
  default_tags = {
    env   = var.environment
    stack = var.stack
  }
}
