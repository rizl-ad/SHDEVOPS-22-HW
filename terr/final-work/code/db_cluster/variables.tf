variable "db_cluster_name" {
  type = string
  default = "mysql-db-cluster"
}

variable "db_environment" {
  type = string
  default = "PRODUCTION"
  validation {
    condition = contains(["PRODUCTION", "PRESTABLE"], var.db_environment)
    error_message = "Invalid MySQL cluster environment, required \"PRESTABLE\" or \"PRODUCTION\""
  }
}

variable "db_version" {
  type = string
  default = "8.0"
  description = "https://terraform-provider.yandexcloud.net/resources/mdb_mysql_cluster"
  validation {
    condition = contains(["5.7", "8.0"], var.db_version)
    error_message = "Invalid MySQL version, required \"5.7\" or \"8.0\""
  }
}

variable "db_node_name" {
  type = string
}

variable "network_id" {
  type = string
}

variable "subnet_zones" {
  type = list(string)
}

variable "subnet_ids" {
  type = list(string)
}

variable "cluster_ha" {
  type = bool
  default = false
}

variable "public_ip" {
  type = bool
}

variable "disk_type_id" {
  type = string
  default = "network-hdd"
  description = "https://yandex.cloud/ru/docs/managed-mysql/concepts/storage"
  validation {
    condition = contains(["network-hdd", "network-ssd", "network-ssd-nonreplicated", "network-ssd-io-m3", "local-ssd"], var.disk_type_id)
    error_message = "Invalid MySQL disk type, see description link"
  }
}

variable "host_class" {
  type = string
  default = "b2.medium"
  description = "https://yandex.cloud/en/docs/managed-mysql/concepts/instance-types"
}

variable "disk_size" {
  type = number
  default = 10
}

locals {
  db_cluster_nodes_count = var.cluster_ha ? 2 : 1
  db_cluster_nodes = [ for i,j in range(local.db_cluster_nodes_count) : {
    name = "${var.db_node_name}${format("%02d", i)}"
    zone = var.subnet_zones[j]
    subnet_id = var.subnet_ids[j]
  }]
}