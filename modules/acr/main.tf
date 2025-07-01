resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku
  admin_enabled       = false

  tags = var.tags
}

resource "azurerm_private_endpoint" "acr_private_endpoint" {
  name                = "${var.acr_name}-pe"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "${var.acr_name}-psc"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_container_registry.acr.id
    subresource_names              = ["registry"]
  }
}

resource "azurerm_private_dns_zone" "acr_private_dns_zone" {
  name                = var.acr_private_dns_zone_name
  resource_group_name = var.resource_group_name
}

