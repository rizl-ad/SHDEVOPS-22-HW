variable "cluster_nodes_count" {
  type = number
}

variable "zones" {
  type = list(string)
}

variable "subnet_ids" {
  type = list(string)
}

variable "backup_retain_period_days" {
  type = number
  default = null
}

variable "deletion_protection" {
  type = bool
  default = null
}

variable "description" {
  type = string
  default = null
}

variable "disk_encryption_key_id" {
  type = string
  default = null
}

variable "environment" {
  type = string
  default = "PRODUCTION"
  validation {
    condition = contains(["PRODUCTION", "PRESTABLE"], var.environment)
    error_message = "Invalid MySQL cluster environment, required \"PRESTABLE\" or \"PRODUCTION\""
  }
}

variable "folder_id" {
  type = string
  default = null
}

variable "host_group_ids" {
  type = set(string)
  default = null
}

variable "labels" {
  type = map(string)
  default = null
}

variable "mysql_config" {
  type = map(string)
  default = null
}

variable "name" {
  type = string
}

variable "network_id" {
  type = string
}

variable "security_group_ids" {
  type = set(string)
  default = null
}

variable "mysql_version" {
  type = string
  validation {
    condition = contains(["5.7", "8.0", "8.4"], var.mysql_version)
    error_message = "Invalid MySQL version, required \"5.7\" or \"8.0\""
  }
  description = "https://terraform-provider.yandexcloud.net/resources/mdb_mysql_cluster"
}

variable "access" {
  type = object({
    data_lens = optional(bool)
    data_transfer = optional(bool)
    web_sql = optional(bool)
    yandex_query = optional(bool)
  })
  default = null
}

variable "backup_window_start" {
  type = object({
    hours = optional(number)
    minutes = optional(number)
  })
  default = null
}

variable "database" {
  type = list(object({
    name = string
  }))
  default = null
}

variable "disk_size_autoscaling" {
  type = object({
    disk_size_limit = number
    emergency_usage_threshold = optional(number)
    planned_usage_threshold = optional(number)
  })
  default = null
}

variable "host" {
  type = object({
    assign_public_ip = optional(bool)
    backup_priority = optional(number)
    name = optional(string)
    priority = optional(number)
    replication_source_name = optional(string)
    subnet_id = optional(string)
    # zone = string
  })
}

variable "maintenance_window" {
  type = object({
    day = optional(string)
    hour = optional(number)
    type = string
  })
  default = null
  validation {
    condition = var.maintenance_window != null && var.maintenance_window.day != null ? contains(
      ["MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"], var.maintenance_window.day
    ) : true
    error_message = "MySQL cluster maintenance window day must be one of: \"MON\", \"TUE\", \"WED\", \"THU\", \"FRI\", \"SAT\", \"SUN\""
  }
  validation {
    condition = var.maintenance_window != null && var.maintenance_window.hour != null ? var.maintenance_window.hour >= 1 && var.maintenance_window.hour <= 24 : true
    error_message = "MySQL cluster maintenance window hour value must be in range from 1 to 24 inclusive"
  }
  validation {
    condition = var.maintenance_window != null ? contains(["ANYTIME", "WEEKLY"], var.maintenance_window.type) : true
    error_message = "MySQL cluster maintenance window type must be one of: \"ANYTIME\", \"WEEKLY\""
  }
  description = "https://terraform-provider.yandexcloud.net/resources/mdb_mysql_cluster"
}

variable "performance_diagnostics" {
  type = object({
    enabled = optional(bool)
    sessions_sampling_interval = number
    statements_sampling_interval = number
  })
  default = null
}

variable "resources" {
  type = object({
    disk_size = optional(number, 20)
    disk_type_id = optional(string, "network-hdd")
    resource_preset_id = optional(string, "b2.medium")
  })
  validation {
    condition = var.resources != null && var.resources.disk_type_id != null ? contains([
      "network-hdd", "network-ssd", "network-ssd-nonreplicated", "network-ssd-io-m3", "local-ssd"
    ], var.resources.disk_type_id) : true
    error_message = "Invalid MySQL disk type, see https://yandex.cloud/ru/docs/managed-mysql/concepts/instance-types"
  }
  description = "https://yandex.cloud/ru/docs/managed-mysql/concepts/instance-types"
}

variable "restore" {
  type = object({
    backup_id = string
    time = optional(string)
  })
  default = null
}

variable "user" {
  type = list(object({
    authentication_plugin = optional(string)
    global_permissions = optional(set(string))
    name = string
    password = string
    connection_limits = optional(object({
      max_connections_per_hour = optional(number)
      max_questions_per_hour = optional(number)
      max_updates_per_hour = optional(number)
      max_user_connections = optional(number)
    }))
    permission = optional(list(object({
      database_name = string
      roles = optional(list(string))
    })))
  }))
  default = null
  validation {
    condition = var.user != null && var.mysql_version != "5.7" ? contains(
      ["MYSQL_NATIVE_PASSWORD", "CACHING_SHA2_PASSWORD", "SHA256_PASSWORD", "MYSQL_NO_LOGIN", "MDB_IAMPROXY_AUTH"], var.user.authentication_plugin
    ) : true
    error_message = "MySQL cluster user authentication plugin value must be one of: \"MYSQL_NATIVE_PASSWORD\", \"CACHING_SHA2_PASSWORD\", \"SHA256_PASSWORD\", \"MYSQL_NO_LOGIN\", \"MDB_IAMPROXY_AUTH\""
  }
  validation {
    condition = var.user != null && var.mysql_version == "5.7" ? contains(
      ["MYSQL_NATIVE_PASSWORD", "SHA256_PASSWORD", "MYSQL_NO_LOGIN", "MDB_IAMPROXY_AUTH"], var.user.authentication_plugin
    ) : true
    error_message = "MySQL v5.7 cluster user authentication plugin value must be one of: \"MYSQL_NATIVE_PASSWORD\", \"SHA256_PASSWORD\", \"MYSQL_NO_LOGIN\", \"MDB_IAMPROXY_AUTH\""
  }
  validation {
    condition = var.user != null ? contains(
      ["REPLICATION_CLIENT", "REPLICATION_SLAVE", "PROCESS", "FLUSH_OPTIMIZER_COSTS", "SHOW_ROUTINE", "MDB_ADMIN"], var.user.global_permissions
    ) : true
    error_message = "MySQL cluster user global permissions value must be one of: \"REPLICATION_CLIENT\", \"REPLICATION_SLAVE\", \"PROCESS\", \"FLUSH_OPTIMIZER_COSTS\", \"SHOW_ROUTINE\", \"MDB_ADMIN\""
  }
  validation {
    condition = var.user != null && var.user.permission != null ? alltrue([
      for i in var.user.permission.roles : contains([
        "ALL", "ALTER", "ALTER_ROUTINE", "CREATE", "CREATE_ROUTINE", "CREATE_TEMPORARY_TABLES", "CREATE_VIEW",
        "DELETE", "DROP", "EVENT", "EXECUTE", "INDEX", "INSERT", "LOCK_TABLES", "SELECT", "SHOW_VIEW", 
        "TRIGGER", "UPDATE", "REFERENCES"
      ], i)
    ]) : true
    error_message = "MySQL cluster user permission role value must be one of: ALL, ALTER, ALTER_ROUTINE, CREATE, CREATE_ROUTINE, CREATE_TEMPORARY_TABLES, CREATE_VIEW, DELETE, DROP, EVENT, EXECUTE, INDEX, INSERT, LOCK_TABLES, SELECT, SHOW_VIEW, TRIGGER, UPDATE, REFERENCES"
  }
  description = "https://terraform-provider.yandexcloud.net/resources/mdb_mysql_cluster"
}
