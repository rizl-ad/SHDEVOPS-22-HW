module "vpc_net" {
  source = "./vpc/vpc_net"
  net_name = var.network_name
}

module "vpc_subnet" {
  source = "./vpc/vpc_subnet"
  network_id = module.vpc_net.network_id
  subnets = local.subnets
}

module "bucket" {
  source = "./s3/bucket"
  bucket_name = var.bucket_name
  access_read_bucket_objects = true
  versioning = true
}

module "storage_object" {
  depends_on = [ module.bucket ]
  source = "./s3/object"
  bucket_name = var.bucket_name
  object_key = "hw/cloud/w2/screenshot.png"
  source_object = "/home/rizl/Screenshots/Screenshot from 2026-02-03 21-00-32.png"
}

module "index_html" {
  source = "./html/index"
  title = var.vm_group_name
  hostname = var.vm_group_name
  h1 = "https://storage.yandexcloud.net/${var.bucket_name}/${module.storage_object.storage_object_key}"
}

module "cloud_init_vm_group" {
  source = "./cloud_init"
  user_name = var.vm_user_name
  pub_ssh_key_path = var.pub_ssh_key_path
  cloud_init_files = local.cloud_init_files
}

module "vm_group" {
  source = "./vm/vm_group"
  service_account_id = var.vm_service_account_id
  name = var.vm_group_name
  allocation_policy = {
    zones = [ for subnet in module.vpc_subnet.subnets : subnet.zone if subnet.name == "public" ]
  }
  deploy_policy = {
    max_expansion = 1
    max_unavailable = 0
  }
  instance_template = {
    boot_disk = {
      initialize_params = {
        image_id = var.vm_disk_image_id.LAMP
      }
    }
    network_interface = {
      subnet_ids = module.vpc_subnet.subnets[*].id
    }
    resources = {}
    name = var.vm_group_name
    hostname = var.vm_group_name
    labels = {
      project = var.project_name
      owner = var.vm_user_name
    }
    metadata = {
      user-data = module.cloud_init_vm_group.local_file_cloud_init
    }
  }
  scale_policy = {
    fixed_scale = {
      size = var.vm_group_scale
    }
  }
  health_check = {
    healthy_threshold = 2
    interval = 2
    timeout = 1
    tcp_options = {
      port = var.lb_port
    }
  }
  load_balancer = {}
}

module "lb_net" {
  source = "./lb/net"
  name = var.lb_net_name
  attached_target_group = {
    target_group_id = module.vm_group.load_balancer_target_group_id[0]
    healthcheck = {
      name = var.lb_net_listener_hc_name
      tcp_options = {
        port = var.lb_port
      }
    }
  }
  listener = {
    name = var.lb_net_listener_name
    port = var.lb_port
    external_address_spec = {}
  }
}

output "storage_object_url" {
  value = "https://storage.yandexcloud.net/${var.bucket_name}/${module.storage_object.storage_object_key}"
}

output "lb_net_ip_address" {
  value = module.lb_net.lb_ip
}
