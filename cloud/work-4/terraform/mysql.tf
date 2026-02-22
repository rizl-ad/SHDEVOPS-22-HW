module "mysql_cluster" {
  source = "./db/mysql_cluster"
  cluster_nodes_count = var.mysql_cluster_nodes_count
  deletion_protection = true
  environment = var.mysql_environment
  mysql_version = var.mysql_version
  name = var.mysql_cluster_name
  network_id = module.vpc_net.network_id
  subnet_ids = [ for subnet in module.vpc_subnet.subnets : subnet.id if can(regex("^private", subnet.name)) ]
  zones = [ for subnet in module.vpc_subnet.subnets : subnet.zone if can(regex("^private", subnet.name)) ]
  backup_window_start = {
    hours = 23
    minutes = 59
  }
  host = {
    assign_public_ip = false
    name = var.mysql_cluster_nodes_name
  }
  maintenance_window = {
    type = "ANYTIME"
  }
  resources = {}
}

module "mysql_db" {
  source = "./db/mysql_db"
  count = length(var.mysql_db_names)
  cluster_id = module.mysql_cluster.id
  name = var.mysql_db_names[count.index]
}

module "mysql_db_user" {
  depends_on = [ module.mysql_db ]
  source = "./db/mysql_user"
  count = length(var.mysql_db_users)
  cluster_id = module.mysql_cluster.id
  mysql_version = var.mysql_version
  name = var.mysql_db_users[count.index].name
  generate_password = true
  permission = {
    database_name = var.mysql_db_names[0]
    roles = var.mysql_db_users[count.index].roles
  }
}