output "acr_login_server" {
  value       = azurerm_container_registry.acr.login_server
  description = "URL del servidor de login del Azure Container Registry"
}

output "acr_id" {
  value       = azurerm_container_registry.acr.id
  description = "ID del recurso del Azure Container Registry"
}
