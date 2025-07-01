variable "cosmos_account_name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "cosmos_private_dns_zone_name" {
  type = string
}

variable "mongo_database_name" {
  type    = string
  default = "eduiadb"
}

variable "mongo_collection_name" {
  type    = string
  default = "topics"
}

variable "throughput" {
  type    = number
  default = 400
}

variable "default_ttl_seconds" {
  type    = number
  default = -1
}

variable "shard_key" {
  type    = string
  default = "topicId"
}

variable "index_unique_keys" {
  type    = list(string)
  default = ["_id"]
}

variable "index_search_keys" {
  type    = list(string)
  default = ["name"]
}

variable "max_throughput" {
  type    = number
  default = 4000
}

variable "principal_id" {
  type = string
}

variable "tags" {
  type = map(string)
}
