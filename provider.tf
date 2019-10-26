provider "azurerm" {
version = "=1.28.0"
   subscription_id = "*******"
   tenant_id       = "*******"
}

variable "location" {
  default = "westeurope"
}

variable "username" {
  default = "*****"
}

variable "password" {
  default = "*****"
}

variable "adet" {default = "3"}

resource "azurerm_resource_group" "testClient-rg" {
  name     = "testClient-rg"
  location = var.resource_group_location
