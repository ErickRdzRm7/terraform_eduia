data "azurerm_subscription" "primary" {}
resource "azurerm_postgresql_flexible_server" "pg_server" {
  name                   = var.pg_server_name
  resource_group_name    = var.resource_group_name
  location               = var.location
  version                = var.pg_version
  sku_name               = var.pg_sku_name
  storage_mb             = var.pg_storage_mb
  administrator_login    = var.pg_admin_username
  administrator_password = var.pg_admin_password
  zone                   = var.pg_zone
  delegated_subnet_id    = var.subnet_id

  public_network_access_enabled = false
  private_dns_zone_id           = var.pg_private_dns_zone_id

  backup_retention_days = var.pg_backup_retention_days

  tags = var.tags
}

resource "azurerm_postgresql_flexible_server_database" "pg_database" {
  name      = var.pg_database_name
  server_id = azurerm_postgresql_flexible_server.pg_server.id
  charset   = "UTF8"
  collation = "C"
}

resource "azurerm_private_endpoint" "pg_private_endpoint" {
  name                = "${var.pg_server_name}-pe"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "${var.pg_server_name}-psc"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_postgresql_flexible_server.pg_server.id
    subresource_names              = ["postgresqlServer"]
  }
}

resource "azurerm_private_dns_zone" "pg_private_dns_zone" {
  name                = var.pg_private_dns_zone_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_role_definition" "custom_pg_user_role" {
  name        = "CustomPostgreSQLUserRole"
  scope = var.subscription_id
  description = "Permisos para usuarios de PostgreSQL flexible server"

  permissions {
    actions = [
      "Microsoft.DBforPostgreSQL/servers/databases/read",
      "Microsoft.DBforPostgreSQL/servers/read"
    ]
    not_actions = []
  }

  assignable_scopes = [
    data.azurerm_subscription.primary.id
  ]
}

resource "azurerm_role_assignment" "pg_user_role_assignment" {
  scope              = azurerm_postgresql_flexible_server.pg_server.id
  role_definition_id = azurerm_role_definition.custom_pg_user_role.id
  principal_id       = var.principal_id
}