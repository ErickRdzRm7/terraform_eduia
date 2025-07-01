variable "app_service_plan_name" {
  type = string
}

variable "app_service_name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "sku_name" {
  type    = string
  default = "B1"
}

variable "health_check_path" {
  type    = string
  default = "/health"
}

variable "acr_login_server" {
  type = string
}

variable "docker_image_name" {
  type = string
}

variable "docker_image_tag" {
  type    = string
  default = "latest"
}

variable "app_settings" {
  type = map(string)
}

variable "subnet_id" {
  type = string
}

variable "tags" {
  type = map(string)
}
