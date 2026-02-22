variable "vm_user_name" {
  type = string
  sensitive = true
}

variable "pub_ssh_key_path" {
  type = string
  sensitive = true
}

variable "yc_token" {
  type = string
  sensitive = true
}

variable "cloud_id" {
  type = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type = string
  default = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "network_name" {
  type = string
  default = "cloud-w1-t1-vpc"
}

locals {
  subnets = [
    { name = "public-a", zone = "ru-central1-a", v4_cidr = ["192.168.10.0/24"], route_table_id = null },
    { name = "public-b", zone = "ru-central1-b", v4_cidr = ["192.168.11.0/24"], route_table_id = null },
    { name = "public-d", zone = "ru-central1-d", v4_cidr = ["192.168.12.0/24"], route_table_id = null },
    { name = "private-a", zone = "ru-central1-a", v4_cidr = ["192.168.20.0/24"], route_table_id = null },
    { name = "private-b", zone = "ru-central1-b", v4_cidr = ["192.168.21.0/24"], route_table_id = null },
    { name = "private-d", zone = "ru-central1-d", v4_cidr = ["192.168.22.0/24"], route_table_id = null },
  ]
}

variable "service_account_id" {
  type = string
  sensitive = true
}

variable "symmetric_key_name" {
  type = string
  default = "cloud-w3-t1-key"
}

variable "mysql_version" {
  type = string
  default = "8.0"
}

variable "mysql_environment" {
  type = string
  default = "PRESTABLE"
}

variable "mysql_cluster_name" {
  type = string
  default = "cloud-w4-t1-db-cluster"
}

variable "mysql_cluster_nodes_count" {
  type = number
  default = 3
}

variable "mysql_cluster_nodes_name" {
  type = string
  default = "mysql-cl"
}

variable "mysql_db_names" {
  type = list(string)
  default = [ "netology_db" ]
}

variable "mysql_db_user_password_length" {
  type = number
  default = 25
}

variable "mysql_db_user_password_included_punctuation" {
  type = string
  default = "!#$%&?@[]^"
}

variable "mysql_db_users" {
  type = list(object({
    name = string
    roles = list(string)
  }))
  default = [{
    name = "netology-user-01"
    roles = [ "ALL" ]
  },
  {
    name = "netology-user-02"
    roles = [ "EVENT", "EXECUTE", "SELECT" ]
  },
  {
    name = "netology-user-03"
    roles = [ "CREATE", "DELETE", "DROP", "INSERT", "UPDATE" ]
  }]
}

variable "lockbox_secret_key" {
  type = string
  default = "cloud-w4-t1-lockbox-key"
}

variable "k8s_sa_name" {
  type = string
  default = "cloud-w4-t2-k8s-sa"
}

variable "k8s_sa_roles" {
  type = list(string)
  default = [
    "editor", "container-registry.images.puller", "k8s.clusters.agent", 
    "load-balancer.admin", "vpc.publicAdmin", "k8s.tunnelClusters.agent"
  ]
}

variable "k8s_cluster_name" {
  type = string
  default = "cloud-w4-t2-k8s-cluster"
}

variable "k8s_cluster_nodes_name" {
  type = string
  default = "cloud-w4-t2-k8s-node"
}

locals {
  k8s_cluster_nodes_location_subnet = local.subnets[0]
}

variable "phpmyadmin_db_user_index" {
  type = number
  default = 0
}
