output "app_service_principal_id" {
  value       = azurerm_linux_web_app.app_service.identity[0].principal_id
  description = "ID del principal (Managed Identity) asignado al App Service"
}
