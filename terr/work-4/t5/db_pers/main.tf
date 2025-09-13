resource "yandex_mdb_mysql_database" "db_w4_t5" {
  cluster_id = var.db_cluster_id
  name = var.db_name
}

resource "yandex_mdb_mysql_user" "user_db_w4_t5" {
  cluster_id = var.db_cluster_id
  name = var.db_user_name
  password = random_password.db_user_pass.result
  permission {
    database_name = var.db_name
    roles = ["ALL"]
  }
}

resource "random_password" "db_user_pass" {
  length = 16
  special = true
  upper = true
  lower = true
  numeric = true
}