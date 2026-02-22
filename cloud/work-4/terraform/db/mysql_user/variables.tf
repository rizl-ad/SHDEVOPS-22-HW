variable "mysql_version" {
  type = string
}

variable "authentication_plugin" {
  type = string
  default = null
  validation {
    condition = var.authentication_plugin != null && var.mysql_version != "5.7" ? contains(
      ["MYSQL_NATIVE_PASSWORD", "CACHING_SHA2_PASSWORD", "SHA256_PASSWORD", "MYSQL_NO_LOGIN", "MDB_IAMPROXY_AUTH"], var.authentication_plugin
    ) : true
    error_message = "MySQL cluster user authentication plugin value must be one of: \"MYSQL_NATIVE_PASSWORD\", \"CACHING_SHA2_PASSWORD\", \"SHA256_PASSWORD\", \"MYSQL_NO_LOGIN\", \"MDB_IAMPROXY_AUTH\""
  }
  validation {
    condition = var.authentication_plugin != null && var.mysql_version == "5.7" ? contains(
      ["MYSQL_NATIVE_PASSWORD", "SHA256_PASSWORD", "MYSQL_NO_LOGIN", "MDB_IAMPROXY_AUTH"], var.authentication_plugin
    ) : true
    error_message = "MySQL v5.7 cluster user authentication plugin value must be one of: \"MYSQL_NATIVE_PASSWORD\", \"SHA256_PASSWORD\", \"MYSQL_NO_LOGIN\", \"MDB_IAMPROXY_AUTH\""
  }
  description = "https://terraform-provider.yandexcloud.net/resources/mdb_mysql_cluster"
}

variable "cluster_id" {
  type = string
}

variable "generate_password" {
  type = bool
  default = false
}

variable "global_permissions" {
  type = set(string)
  default = null
  validation {
    condition = var.global_permissions != null ? contains(
      ["REPLICATION_CLIENT", "REPLICATION_SLAVE", "PROCESS", "FLUSH_OPTIMIZER_COSTS", "SHOW_ROUTINE", "MDB_ADMIN"], var.global_permissions
    ) : true
    error_message = "MySQL cluster user global permissions value must be one of: \"REPLICATION_CLIENT\", \"REPLICATION_SLAVE\", \"PROCESS\", \"FLUSH_OPTIMIZER_COSTS\", \"SHOW_ROUTINE\", \"MDB_ADMIN\""
  }
  description = "https://terraform-provider.yandexcloud.net/resources/mdb_mysql_cluster"
}

variable "name" {
  type = string
}

variable "password" {
  type = string
  default = null
  sensitive = true
  validation {
    condition = (var.generate_password != false) != (var.password != null) ? true : false
    error_message = "One of two arguments must be specified: generate_password or password"
  }
}

variable "connection_limits" {
  type = object({
    max_connections_per_hour = optional(number)
    max_questions_per_hour = optional(number)
    max_updates_per_hour = optional(number)
    max_user_connections = optional(number)
  })
  default = null
}

variable "permission" {
  type = object({
    database_name = string
    roles = optional(list(string))
  })
  default = null
  validation {
    condition = var.permission != null ? alltrue([
      for i in var.permission.roles : contains([
        "ALL", "ALTER", "ALTER_ROUTINE", "CREATE", "CREATE_ROUTINE", "CREATE_TEMPORARY_TABLES", "CREATE_VIEW",
        "DELETE", "DROP", "EVENT", "EXECUTE", "INDEX", "INSERT", "LOCK_TABLES", "SELECT", "SHOW_VIEW", 
        "TRIGGER", "UPDATE", "REFERENCES"
      ], i)
    ]) : true
    error_message = "MySQL cluster user permission role value must be one of: ALL, ALTER, ALTER_ROUTINE, CREATE, CREATE_ROUTINE, CREATE_TEMPORARY_TABLES, CREATE_VIEW, DELETE, DROP, EVENT, EXECUTE, INDEX, INSERT, LOCK_TABLES, SELECT, SHOW_VIEW, TRIGGER, UPDATE, REFERENCES"
  }
  description = "https://terraform-provider.yandexcloud.net/resources/mdb_mysql_cluster"
}
