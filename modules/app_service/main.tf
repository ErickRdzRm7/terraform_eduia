resource "azurerm_service_plan" "app_service_plan" {
  name                = "${var.app_service_plan_name}"
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = "Linux"
  sku_name            = var.sku_name

  tags = var.tags
}

resource "azurerm_linux_web_app" "app_service" {
  name                = var.app_service_name
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.app_service_plan.id

  identity {
    type = "SystemAssigned"
  }

  site_config {
    always_on         = true
    health_check_path = var.health_check_path

    application_stack {
      docker_image     = "${var.acr_login_server}/${var.docker_image_name}"
      docker_image_tag = var.docker_image_tag
    }

    container_registry_use_managed_identity = true
  }

  app_settings = var.app_settings

  virtual_network_subnet_id = var.subnet_id

  tags = var.tags
}
