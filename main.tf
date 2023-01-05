provider "azurerm" {
  features {}
}

variable "env_name" {
  type = string
}
variable "redis_capacity" {
  type = number
}

locals {
  default_tags = {
    owner     = "rpapovyan@infra.st.dev"
    createdBy = "rpapovyan@infra.st.dev"
    squad     = "infra"
  }
}

resource "azurerm_resource_group" "this" {
  name     = "${var.env_name}-rg"
  location = "West US 2"
  tags     = local.default_tags
}

resource "azurerm_redis_cache" "this" {
  name                = "${var.env_name}-cache"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  capacity            = var.redis_capacity
  family              = "C"
  sku_name            = "Standard"
  enable_non_ssl_port = false
  minimum_tls_version = "1.2"

  redis_configuration {
  }

  tags = local.default_tags
}

output "connection_string" {
  value = azurerm_redis_cache.this.primary_connection_string
}
