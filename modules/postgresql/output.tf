output "pg_server_fqdn" {
  value = azurerm_postgresql_flexible_server.pg_server.fqdn
}

output "pg_database_name" {
  value = azurerm_postgresql_flexible_server_database.pg_database.name
}
