resource "azurerm_cosmosdb_account" "cosmos_db_account" {
  name                = var.cosmos_account_name
  location            = var.location
  resource_group_name = var.resource_group_name
  offer_type          = "Standard"
  kind                = "MongoDB"
  consistency_policy {
    consistency_level = "Session"
  }

  capabilities {
    name = "EnableMongo"
  }

  geo_location {
    location          = var.location
    failover_priority = 0
  }

  public_network_access_enabled = false

  tags = var.tags
}

resource "azurerm_private_endpoint" "cosmos_db_private_endpoint" {
  name                = "${var.cosmos_account_name}-pe"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "${var.cosmos_account_name}-psc"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_cosmosdb_account.cosmos_db_account.id
    subresource_names              = ["MongoDB"]
  }
}

resource "azurerm_private_dns_zone" "cosmos_db_private_dns_zone" {
  name                = var.cosmos_private_dns_zone_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_cosmosdb_mongo_database" "cosmos_db_mongo_database" {
  name                = var.mongo_database_name
  resource_group_name = var.resource_group_name
  account_name        = azurerm_cosmosdb_account.cosmos_db_account.name

  throughput = var.throughput
}

resource "azurerm_cosmosdb_mongo_collection" "cosmos_db_mongo_collection" {
  name                = var.mongo_collection_name
  resource_group_name = var.resource_group_name
  account_name        = azurerm_cosmosdb_account.cosmos_db_account.name
  database_name       = azurerm_cosmosdb_mongo_database.cosmos_db_mongo_database.name
  default_ttl_seconds = var.default_ttl_seconds
  shard_key           = var.shard_key

  index {
    keys   = var.index_unique_keys
    unique = true
  }

  index {
    keys = var.index_search_keys
  }

  autoscale_settings {
    max_throughput = var.max_throughput
  }
}

resource "azurerm_role_assignment" "cosmos_db_contributor_role_assignment" {
  scope                = azurerm_cosmosdb_account.cosmos_db_account.id
  role_definition_name = "Cosmos DB Built-in Data Contributor"
  principal_id         = var.principal_id
}
