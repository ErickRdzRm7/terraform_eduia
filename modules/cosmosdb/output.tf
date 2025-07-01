output "cosmos_db_account_name" {
  value = azurerm_cosmosdb_account.cosmos_db_account.name
}

output "mongo_database_name" {
  value = azurerm_cosmosdb_mongo_database.cosmos_db_mongo_database.name
}
