module "k8s_sa" {
  source = "./iam/sa"
  name = var.k8s_sa_name
}

module "k8s_sa_roles" {
  source = "./rm/folder_iam_member"
  count = length(var.k8s_sa_roles)
  folder_id = var.folder_id
  member = "serviceAccount:${module.k8s_sa.id}"
  role = var.k8s_sa_roles[count.index]
}

module "k8s_cluster" {
  source = "./k8s/cluster"
  name = var.k8s_cluster_name
  network_id = module.vpc_net.network_id
  node_service_account_id = module.k8s_sa.id
  service_account_id = module.k8s_sa.id
  kms_provider = {
    key_id = module.symmetric_key.id
  }
  master = {
    public_ip = true
    version = "1.33"
    regional = {
      location = {
        subnet_ids = [ for subnet in module.vpc_subnet.subnets : subnet.id if can(regex("^public", subnet.name)) ]
        zones = [ for subnet in module.vpc_subnet.subnets : subnet.zone if can(regex("^public", subnet.name)) ]
      }
    }
  }
  network_implementation = {
    cilium = {}
  }
}

module "k8s_cluster_nodes" {
  source = "./k8s/node_group"
  cluster_id = module.k8s_cluster.id
  name = var.k8s_cluster_nodes_name
  allocation_policy = {
    location = {
      zone = local.k8s_cluster_nodes_location_subnet.zone
    }
  }
  instance_template = {
    metadata = { ssh-keys = "${var.vm_user_name}:${file(var.pub_ssh_key_path)}" }
    name = var.k8s_cluster_nodes_name
    boot_disk = {}
    network_interface = {
      nat = true
      subnet_ids = [ for subnet in module.vpc_subnet.subnets : subnet.id if (
        subnet.name == local.k8s_cluster_nodes_location_subnet.name && 
        subnet.zone == local.k8s_cluster_nodes_location_subnet.zone
      )]
    }
    resources = {}
    scheduling_policy = {}
  }
  scale_policy = {
    auto_scale = {
      initial = 3
      max = 6
      min = 3
    }
  }
}

module "deployment" {
  source = "./k8s/deployment"
  metadata = {
    name = var.phpmyadmin_name
    labels = { 
      app = var.phpmyadmin_name
    }
  }
  spec = {
    replicas = 1
    selector = { 
      match_labels = { 
        app = var.phpmyadmin_name 
      }
    }
    template = {
      metadata = { 
        labels = { 
          app = var.phpmyadmin_name 
        }
      }
      spec = {
        container = [{
          image = "${var.phpmyadmin_name}:latest"
          name  = var.phpmyadmin_name
          port = [{
            container_port = var.phpmyadmin_port
          }]
          env = [{
            name  = "PMA_HOST"
            value = "c-${module.mysql_cluster.id}.rw.mdb.yandexcloud.net"
          },
          {
            name = "PMA_DB"
            value = var.mysql_db_names[var.phpmyadmin_db_user_index]
          },
          {
            name = "PMA_USER"
            value = var.mysql_db_users[var.phpmyadmin_db_user_index].name
          },
          {
            name = "PMA_PASSWORD"
            value = module.mysql_db_user_secret_version_data.secret_value
          }]
        }]
      }
    }
  }
}

module "service" {
  source = "./k8s/service"
  metadata = {
    name = "${var.phpmyadmin_name}-service"
  }
  spec = {
    selector = {
      app = var.phpmyadmin_name
    }
    port = [{
      port = var.phpmyadmin_port
      target_port = var.phpmyadmin_port
    }]
    type = "LoadBalancer"
  }
}


output "phpmyadmin_external_ip" {
  value = module.service.status[0].load_balancer[0].ingress[0].ip
}
