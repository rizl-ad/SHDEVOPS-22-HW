resource "yandex_mdb_mysql_cluster" "mysql_db_cluster" {
  name = var.db_cluster_name
  environment = var.db_environment
  network_id = var.network_id
  version = var.db_version
  deletion_protection = true

  resources {
    resource_preset_id = "b2.medium"
    disk_type_id = "network-hdd"
    disk_size = 10
  }

  dynamic host {
    for_each = local.db_cluster_nodes
    content {
      zone = host.value.zone
      subnet_id = host.value.subnet_id
      assign_public_ip = true
    }
  }
}

output "db_cluster_id" {
  value = yandex_mdb_mysql_cluster.mysql_db_cluster.id
}