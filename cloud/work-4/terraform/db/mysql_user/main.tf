resource "yandex_mdb_mysql_user" "mysql_user" {
  authentication_plugin = var.authentication_plugin
  cluster_id = var.cluster_id
  generate_password = var.generate_password
  global_permissions = var.global_permissions
  name = var.name
  password = var.password

  dynamic "connection_limits" {
    for_each = var.connection_limits != null ? [1] : []
    content {
      max_connections_per_hour = var.connection_limits.max_connections_per_hour
      max_questions_per_hour = var.connection_limits.max_questions_per_hour
      max_updates_per_hour = var.connection_limits.max_updates_per_hour
      max_user_connections = var.connection_limits.max_user_connections
    }
  }

  dynamic "permission" {
    for_each = var.permission != null ? [1] : []
    content {
      database_name = var.permission.database_name
      roles = var.permission.roles
    }
  }
}

output "connection_manager" {
  value = yandex_mdb_mysql_user.mysql_user.connection_manager
}

output "id" {
  value = yandex_mdb_mysql_user.mysql_user.id
}

output "name" {
  value = yandex_mdb_mysql_user.mysql_user.name
}
