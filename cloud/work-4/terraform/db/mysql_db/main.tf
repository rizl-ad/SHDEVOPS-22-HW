resource "yandex_mdb_mysql_database" "mysql_database" {
  cluster_id = var.cluster_id
  name = var.name
}

output "id" {
  value = yandex_mdb_mysql_database.mysql_database.id
}
