provider "azurerm" {
  features {}

  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
  client_id       = var.client_id
  client_secret   = var.client_secret
}

resource "random_id" "app_name" {
  byte_length = 8
}

resource "azurerm_resource_group" "rg" {
  name     = "springboot-rg"
  location = "westeurope"
}

resource "azurerm_service_plan" "asp" {
  name                = "springboot-asp"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Linux"
  sku_name            = "F1"
}

resource "azurerm_linux_web_app" "app" {
  name                = "${var.app_service_name}-${random_id.app_name.hex}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.asp.id

  site_config {
    always_on = false
    application_stack {
      java_version        = "17"
      java_server         = "JAVA"
      java_server_version = "17"
    }
  }
}