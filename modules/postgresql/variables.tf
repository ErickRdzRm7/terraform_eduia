variable "pg_server_name" {
  description = "Nombre del servidor PostgreSQL."
  type        = string
}

variable "resource_group_name" {
  description = "Nombre del grupo de recursos."
  type        = string
}

variable "principal_id" {
  description = "Principal ID para la asignación de rol"
  type        = string
}

variable "location" {
  description = "Región donde se desplegarán los recursos."
  type        = string
}

variable "pg_version" {
  description = "Versión de PostgreSQL."
  type        = string
  default     = "13"
}
variable "pg_database_name" {
  description = "Nombre de la base de datos PostgreSQL"
  type        = string
}

variable "pg_private_dns_zone_id" {
  description = "ID de la zona DNS privada para PostgreSQL"
  type        = string
}

variable "pg_private_dns_zone_name" {
  description = "Nombre de la zona DNS privada para PostgreSQL"
  type        = string
}



variable "pg_sku_name" {
  description = "SKU del servidor PostgreSQL."
  type        = string
  default     = "GP_Standard_D2ds_v4"
}

variable "pg_storage_mb" {
  description = "Tamaño del almacenamiento en MB."
  type        = number
  default     = 32768
}

variable "pg_admin_username" {
  description = "Nombre de usuario administrador."
  type        = string
}

variable "pg_admin_password" {
  description = "Contraseña del usuario administrador."
  type        = string
  sensitive   = true
}

variable "pg_zone" {
  description = "Zona de disponibilidad."
  type        = string
  default     = "1"
}

variable "subnet_id" {
  description = "ID de la subred delegada."
  type        = string
}


variable "pg_backup_retention_days" {
  description = "Cantidad de días para retención de respaldos."
  type        = number
  default     = 7
}

variable "tags" {
  description = "Etiquetas comunes para los recursos."
  type        = map(string)
}
