variable "db_cluster_name" {
  type = string
  default = "mysql-db-cluster"
}

variable "db_environment" {
  type = string
  default = "PRODUCTION"
}

variable "db_version" {
  type = string
  default = "8.0"
}

variable "network_id" {
  type = string
}

variable "zones" {
  type = list(string)
  #default = ["ru-central1-a"]
}

variable "subnet_id" {
  type = list(string)
}

variable "ha" {
  type = bool
  default = false
}

locals {
  db_cluster_nodes_count = var.ha ? 2 : 1
  db_cluster_nodes = [ for i in range(local.db_cluster_nodes_count) : {
    zone = var.zones[i]
    subnet_id = var.subnet_id[i]
  }]
}