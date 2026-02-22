module "mysql_db_user_secret_data" {
  source = "./lockbox/data_secret"
  name = "connection-${module.mysql_db_user[var.phpmyadmin_db_user_index].connection_manager.connection_id}"
}

module "mysql_db_user_secret_version_data" {
  source = "./lockbox/data_secret_version"
    secret_id = module.mysql_db_user_secret_data.id
}
