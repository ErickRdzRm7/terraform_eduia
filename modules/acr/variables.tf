variable "acr_name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "sku" {
  type    = string
  default = "Premium"
}

variable "subnet_id" {
  type = string
}

variable "acr_private_dns_zone_name" {
  type = string
}

variable "tags" {
  type = map(string)
}
