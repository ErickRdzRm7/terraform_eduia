output "resource_group_name" {
  value = var.resource_group_name
}

output "virtual_network_id" {
  value = azurerm_virtual_network.vnet.id
}

output "app_service_subnet_id" {
  value = azurerm_subnet.app_service_pe_subnet.id
}

output "postgresql_subnet_id" {
  value = azurerm_subnet.postgresql_delegated_subnet.id
}

output "pg_private_dns_zone_id" {
  value = azurerm_private_dns_zone.pg_private_dns_zone.id
}


output "pg_private_dns_zone_name" {
  value = azurerm_private_dns_zone.pg_private_dns_zone.name
}

output "vnet_id" {
  description = "ID de la Virtual Network"
  value       = azurerm_virtual_network.vnet.id
}
