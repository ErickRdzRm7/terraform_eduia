
variable "environment_type" {
  type = string
}

variable "app_name" {
  type = string
}

variable "location" {
  type = string
}
variable "resource_group_name" {
  description = "Nombre del grupo de recursos"
  type        = string
}


variable "tags" {
  description = "Etiquetas para recursos"
  type        = map(string)
  default     = {}
}