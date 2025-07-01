variable "location" {
  description = "La región de Azure para los recursos."
  type        = string
  default     = "centralus"
}

variable "app_name" {
  description = "Prefijo para los nombres de los recursos de la aplicación."
  type        = string
  default     = "eduia"
}

variable "environment_type" {
  description = "Tipo de entorno para etiquetado (ej. Production, Development)."
  type        = string
  default     = "Development"
}

variable "postgresql_admin_username" {
  description = "Usuario administrador de PostgreSQL."
  type        = string
}


variable "postgresql_admin_password" {
  description = "Contraseña del administrador de PostgreSQL."
  type        = string
  sensitive   = true
}


variable "gemini_api_key" {
  description = "Clave de la API de Gemini."
  type        = string
  sensitive   = true
}
