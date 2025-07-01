output "resource_group_name" {
  value       = var.resource_group_name
  description = "Nombre del grupo de recursos utilizado por la red"
}

output "postgresql_subnet_id" {
  value       = azurerm_subnet.postgresql_delegated_subnet.id
  description = "ID de la subred delegada para PostgreSQL Flexible Server"
}

output "pg_private_dns_zone_id" {
  value       = azurerm_private_dns_zone.pg_private_dns_zone.id
  description = "ID de la zona DNS privada para PostgreSQL"
}

output "pg_private_dns_zone_name" {
  value       = azurerm_private_dns_zone.pg_private_dns_zone.name
  description = "Nombre de la zona DNS privada para PostgreSQL"
}

output "vnet_id" {
  value       = azurerm_virtual_network.vnet.id
  description = "ID de la Virtual Network"
}

output "private_endpoints_subnet_id" {
  description = "ID de la subred para endpoints privados"
  value       = azurerm_subnet.private_endpoints_subnet.id
}



output "app_service_subnet_id" {
  value       = azurerm_subnet.app_service_subnet.id
  description = "ID de la subred delegada para App Service"
}
