resource "azurerm_resource_group" "redis" {
  name                            = "${var.project}-${var.environment}-rg-redis"
  location                        = var.region
  tags = {
    environment                   = var.environment
  }
}

resource "azurerm_redis_cache" "redis" {
  name                = "${var.project}-${var.environment}-redis"
  location            = var.region
  resource_group_name = azurerm_resource_group.redis.name
  capacity            = 1
  family              = "C"
  sku_name            = "Standard"
  enable_non_ssl_port = false
  minimum_tls_version = "1.2"

  redis_configuration {
  }
}
