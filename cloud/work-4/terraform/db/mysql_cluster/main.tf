resource "yandex_mdb_mysql_cluster" "mysql_cluster" {
  backup_retain_period_days = var.backup_retain_period_days
  deletion_protection = var.deletion_protection
  description = var.description
  disk_encryption_key_id = var.disk_encryption_key_id
  environment = var.environment
  folder_id = var.folder_id
  host_group_ids = var.host_group_ids
  labels = var.labels
  mysql_config = var.mysql_config
  name = var.name
  network_id = var.network_id
  security_group_ids = var.security_group_ids
  version = var.mysql_version

  dynamic "access" {
    for_each = var.access != null ? [var.access] : []
    content {
      data_lens = access.value.data_lens
      data_transfer = access.value.data_transfer
      web_sql = access.value.web_sql
      yandex_query = access.value.yandex_query
    }
  }

  dynamic "backup_window_start" {
    for_each = var.backup_window_start != null ? [var.backup_window_start] : []
    content {
      hours = backup_window_start.value.hours
      minutes = backup_window_start.value.minutes
    }
  }

  dynamic "database" {
    for_each = var.database != null ? var.database : []
    content {
      name = database.value.name
    }
  }

  dynamic "disk_size_autoscaling" {
    for_each = var.disk_size_autoscaling != null ? [var.disk_size_autoscaling] : []
    content {
      disk_size_limit = disk_size_autoscaling.value.disk_size_limit
      emergency_usage_threshold = disk_size_autoscaling.value.emergency_usage_threshold
      planned_usage_threshold = disk_size_autoscaling.value.planned_usage_threshold
    }
  }

  dynamic "host" {
    for_each = range(var.cluster_nodes_count)
    content {
      assign_public_ip = var.host.assign_public_ip
      backup_priority = var.host.backup_priority
      name = "${var.host.name}-${format("%02d", host.value + 1)}"
      priority = var.host.priority
      replication_source_name = var.host.replication_source_name
      subnet_id = element(var.subnet_ids, host.value)
      zone = element(var.zones, host.value)
    }
  }

  dynamic "maintenance_window" {
    for_each = var.maintenance_window != null ? [var.maintenance_window] : []
    content {
      day = maintenance_window.value.day
      hour = maintenance_window.value.hour
      type = maintenance_window.value.type
    }
  }

  dynamic "performance_diagnostics" {
    for_each = var.performance_diagnostics != null ? [var.performance_diagnostics] : []
    content {
      enabled = performance_diagnostics.value.enabled
      sessions_sampling_interval = performance_diagnostics.value.sessions_sampling_interval
      statements_sampling_interval = performance_diagnostics.value.statements_sampling_interval
    }
  }

  dynamic "resources" {
    for_each = var.resources != null ? [var.resources] : []
    content {
      disk_size = var.resources.disk_size
      disk_type_id = var.resources.disk_type_id
      resource_preset_id = var.resources.resource_preset_id
    }
  }

  dynamic "restore" {
    for_each = var.restore != null ? [var.restore] : []
    content {
      backup_id = restore.value.backup_id
      time = restore.value.time
    }
  }

  dynamic "user" {
    for_each = var.user != null ? var.user : []
    content {
      authentication_plugin = user.value.authentication_plugin
      global_permissions = user.value.global_permissions
      name = user.value.name
      password = user.value.password

      dynamic "connection_limits" {
        for_each = user.value.connection_limits != null ? [user.value.connection_limits] : []
        content {
          max_connections_per_hour = connection_limits.value.max_connections_per_hour
          max_questions_per_hour = connection_limits.value.max_questions_per_hour
          max_updates_per_hour = connection_limits.value.max_updates_per_hour
          max_user_connections = connection_limits.value.max_user_connections
        }
      }

      dynamic "permission" {
        for_each = user.value.permission != null ? user.value.permission : []
        content {
          database_name = permission.value.database_name
          roles = permission.value.roles
        }
      }
    }
  }
}

output "created_at" {
  value = yandex_mdb_mysql_cluster.mysql_cluster.created_at
}

output "health" {
  value = yandex_mdb_mysql_cluster.mysql_cluster.health
}

output "status" {
  value = yandex_mdb_mysql_cluster.mysql_cluster.status
}

output "id" {
  value = yandex_mdb_mysql_cluster.mysql_cluster.id
}

output "fqdn_list" {
  value = yandex_mdb_mysql_cluster.mysql_cluster.host[*].fqdn
}

output "replication_sources" {
  value = yandex_mdb_mysql_cluster.mysql_cluster.host[*].replication_source
}