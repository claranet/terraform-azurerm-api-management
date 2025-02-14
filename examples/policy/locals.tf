locals {
  allowed_cidrs = [data.azurerm_network_service_tags.fd_ips.ipv4_cidrs]
  afd_guid      = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
}
