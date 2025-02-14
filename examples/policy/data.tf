data "azurerm_network_service_tags" "fd_ips" {
  location = "francecentral"
  service  = "AzureFrontDoor.Backend"
}
