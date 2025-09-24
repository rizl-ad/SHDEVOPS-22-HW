module "vpc" {
  source = "./vpc"
  net_name = var.network_name
  subnets = [
    {zone = "ru-central1-a", v4_cidr = ["10.0.10.0/24", "10.0.11.0/24", "10.0.12.0/24"]},
    {zone = "ru-central1-b", v4_cidr = ["10.0.20.0/24", "10.0.21.0/24"]},
    {zone = "ru-central1-d", v4_cidr = ["10.0.30.0/24", "10.0.31.0/24"]},
  ]
}

module "security_group" {
  source = "./sg"
  security_group_name = var.security_group_name
  folder_id = var.folder_id
  network_id = module.vpc.network_id
}

module "vm_app" {
  depends_on = [module.db_cluster]
  source = "./vm_app"
  vm_count = 1
  vm_user_name = var.vm_user_name
  subnet_ids = module.vpc.subnets[*].id
  vm_name = var.vm_app_name
  vm_public_ip = true
  vm_service_account_id = var.vm_service_account_id
  vm_security_group_ids = [module.security_group.vm_security_group_id]
  vm_labels = {
    project = var.project_name
    owner = var.vm_user_name
  }
  vm_metadata = {
    user-data = module.vm_app.local_file_cloud_init
  }
  run_cmd = [
    "export HOME=/home/${var.vm_user_name}",
    "cd $HOME",
    "curl -fsSL https://get.docker.com -o get-docker.sh",
    "sudo sh get-docker.sh",
    "sudo usermod -aG docker ${var.vm_user_name}",
    "git clone https://github.com/rizl-ad/terr-final-work-docker-files app",
    "cd app",
    "echo \"DB_HOST=c-${module.db_cluster.db_cluster_id}.rw.mdb.yandexcloud.net\" >> .env",
    "echo \"DB_USER=${var.db_user_name}\" >> .env",
    "echo \"DB_PASSWORD=${module.db_user_password.secret_value}\" >> .env",
    "echo \"DB_NAME=${var.db_name}\" >> .env",
    "wget \"https://storage.yandexcloud.net/cloud-certs/CA.pem\" --output-document root.crt && chmod 0600 root.crt",
    "sudo chown -R ${var.vm_user_name}:${var.vm_user_name} $HOME/app",
    "docker compose up -d",
    "cd $HOME",
    "curl https://storage.yandexcloud.net/yandexcloud-yc/install.sh | bash",
    "docker tag python_web_app_terr_final_work:3.12-slim cr.yandex/${module.container_registry.cr_id}/python_web_app_terr_final_work:3.12-slim",
    "export PATH=$PATH:$HOME/yandex-cloud/bin",
    "echo ${var.yc_token} | docker login --username oauth --password-stdin cr.yandex",
    "sudo chown -R ${var.vm_user_name}:${var.vm_user_name} .config",
    "sudo chown -R ${var.vm_user_name}:${var.vm_user_name} .docker",
    "sudo chown -R ${var.vm_user_name}:${var.vm_user_name} yandex-cloud",
    "docker push cr.yandex/${module.container_registry.cr_id}/python_web_app_terr_final_work:3.12-slim"
  ]
}

module "db_cluster" {
  source = "./db_cluster"
  db_cluster_name = var.db_cluster_name
  db_node_name = var.db_node_name
  network_id = module.vpc.network_id
  subnet_zones = module.vpc.subnets[*].zone
  subnet_ids = module.vpc.subnets[*].id
  cluster_ha = true
  public_ip = false
}

module "db_cluster_pers" {
  depends_on = [module.db_cluster]
  source = "./db_pers"
  db_cluster_id = module.db_cluster.db_cluster_id
  db_name = var.db_name
  db_user_name = var.db_user_name
  db_user_password = module.db_user_password.secret_value
}

module "db_user_password" {
  source = "./lockbox"
  name = var.secret_name
  password_key = var.secret_pass_key
  folder_id = var.folder_id
  length = 25
  included_punctuation = "!#$%&-=?@[]^"
  deletion_protection = true
}

module "container_registry" {
  source = "./cr"
  cr_name = var.cr_name
  folder_id = var.folder_id
  cr_labels = {
    project = var.project_name
  }
}