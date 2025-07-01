output "resource_group_name" {
  value = module.network.resource_group_name
}

output "vnet_id" {
  value = module.network.vnet_id
}

output "acr_login_server" {
  value = module.acr.acr_login_server
}

output "pg_server_fqdn" {
  value = module.postgresql.pg_server_fqdn
}

output "pg_database_name" {
  value = module.postgresql.pg_database_name
}

output "cosmos_db_account_name" {
  value = module.cosmosdb.cosmos_db_account_name
}

output "mongo_database_name" {
  value = module.cosmosdb.mongo_database_name
}

output "app_service_principal_id" {
  value = module.app_service.app_service_principal_id
}
