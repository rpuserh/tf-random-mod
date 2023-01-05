variable "env_name" {
  type = string
}
variable "redis_capacity" {
  type = number
}

resource "azurerm_resource_group" "this" {
  name     = "${var.env_name}-rg"
  location = "West US 2"
}

resource "azurerm_redis_cache" "this" {
  name                = "${env_name}-cache"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  capacity            = var.redis_capacity
  family              = "C"
  sku_name            = "Standard"
  enable_non_ssl_port = false
  minimum_tls_version = "1.2"

  redis_configuration {
  }
}

output "redis_name" {
  value = azurerm_redis_cache.this.name
}
