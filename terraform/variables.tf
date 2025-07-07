variable "location" {
  default = "westeurope"
}

variable "resource_group_name" {
  default = "springboot-rg"
}

variable "app_service_name" {
  description = "Base name for app service"
  default = "springboot-webapp"
}
variable "subscription_id" {}
variable "tenant_id" {}
variable "client_id" {}
variable "client_secret" {}