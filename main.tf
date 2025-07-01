provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-${var.app_name}"
  location = var.location
}

module "network" {
  source = "./modules/network"

  resource_group_name        = "rg-${var.app_name}"
  location                   = var.location
  environment_type           = var.environment_type
  app_name                   = var.app_name

  tags = {
    Environment = var.environment_type
    Application = var.app_name
  }
}

module "acr" {
  source = "./modules/acr"

  acr_name                  = "${var.app_name}acr"
  resource_group_name       = module.network.resource_group_name
  location                  = var.location
  sku                       = "Premium"
  subnet_id                 = module.network.app_service_subnet_id
  acr_private_dns_zone_name = "privatelink.${var.app_name}acr.azurecr.io"
  depends_on = [module.network]
  tags = {
    Environment = var.environment_type
    Application = var.app_name
  }
}

module "postgresql" {
  source = "./modules/postgresql"

  pg_server_name           = "${var.app_name}pgserver"
  resource_group_name      = module.network.resource_group_name
  location                 = "eastus"
  pg_version               = "13"
  pg_sku_name              = "GP_Standard_D2ds_v4"
  pg_storage_mb            = 32768
  pg_admin_username        = var.postgresql_admin_username
  pg_admin_password        = var.postgresql_admin_password
  principal_id = module.app_service.app_service_principal_id
  pg_database_name         = "topicsdb"
  pg_zone                  = "1"
  subnet_id                = module.network.postgresql_subnet_id
  pg_private_dns_zone_id = module.network.pg_private_dns_zone_id
  pg_private_dns_zone_name = module.network.pg_private_dns_zone_name
  pg_backup_retention_days = 7
  depends_on = [module.network]
  tags = {
    Environment = var.environment_type
    Application = var.app_name
  }
}


module "cosmosdb" {
  source = "./modules/cosmosdb"

  cosmos_account_name        = "${var.app_name}cosmosdb"
  resource_group_name        = module.network.resource_group_name
  location                   = var.location
  subnet_id                 = module.network.app_service_subnet_id
  cosmos_private_dns_zone_name = "privatelink.mongo.cosmos.azure.com"
  principal_id               = module.app_service.app_service_principal_id

  tags = {
    Environment = var.environment_type
    Application = var.app_name
  }
}

module "app_service" {
  source = "./modules/app_service"

  app_service_plan_name = "${var.app_name}-plan"
  app_service_name      = "${var.app_name}-api"
  resource_group_name   = module.network.resource_group_name
  location              = var.location
  sku_name              = "B1"
  acr_login_server      = module.acr.acr_login_server
  docker_image_name     = "${var.app_name}api"
  docker_image_tag      = "latest"
  subnet_id             = module.network.app_service_subnet_id
  health_check_path     = "/health"

  app_settings = {
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE"    = "false"
    "DOCKER_REGISTRY_SERVER_URL"             = module.acr.acr_login_server
    "GEMINI_API_KEY"                         = var.gemini_api_key
    "DATABASE_HOST_PG"                       = module.postgresql.pg_server_fqdn
    "DATABASE_NAME_PG"                       = module.postgresql.pg_database_name
    "DATABASE_HOST_COSMOS"                   = module.cosmosdb.cosmos_db_account_name
    "DATABASE_NAME_COSMOS"                   = module.cosmosdb.mongo_database_name
    # Agrega aquí otras variables de entorno necesarias
  }

  tags = {
    Environment = var.environment_type
    Application = var.app_name
  }
}
