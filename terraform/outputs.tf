output "webapp_name" {
  value = "${var.app_service_name}-${random_id.app_name.hex}"
}

output "web_app_url" {
  value = azurerm_linux_web_app.app.default_hostname
}