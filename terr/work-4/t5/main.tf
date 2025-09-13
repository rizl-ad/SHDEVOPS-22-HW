module "vpc" {
  source = "/home/rizl/terr/work-4/vpc"
  net_name = "terr-w4-t2"
  subnets = [
    {zone = "ru-central1-a", v4_cidr = ["10.0.10.0/24", "10.0.11.0/24", "10.0.12.0/24"]},
    {zone = "ru-central1-b", v4_cidr = ["10.0.20.0/24", "10.0.21.0/24"]},
    {zone = "ru-central1-d", v4_cidr = ["10.0.30.0/24", "10.0.31.0/24"]},
  ]
}

module "db_cluster" {
  source = "./db"
  ha = false
  network_id = module.vpc.network_id
  subnet_id = module.vpc.subnets[*].id
  zones = module.vpc.subnets[*].zone
}

module "db_cluster_pers" {
  source = "./db_pers"
  db_cluster_id = module.db_cluster.db_cluster_id
  db_name = "db_w4_t5"
  db_user_name = "app"
}

