terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
    
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">=1.8.4"
}

provider "yandex" {
  token = var.yc_token
  cloud_id = var.yc_cloud_id
  folder_id = var.yc_folder_id
  zone = var.yc_compute_default_zone
}

provider "docker" {
  host = "ssh://${var.vm_user_name}@${data.yandex_compute_instance.vm_terr_w1_t2.network_interface.0.nat_ip_address}"
  ssh_opts = ["-o", "StrictHostKeyChecking=no", "-o", "UserKnownHostsFile=/dev/null"]
}

data "yandex_compute_instance" "vm_terr_w1_t2" {
  name = "vm-terr-w1-t2"
}

#resource "local_file" "ssh_config" {
#  content = <<-EOF
#    Host ${data.yandex_compute_instance.vm_terr_w1_t2.network_interface.0.nat_ip_address}
#      HostName ${data.yandex_compute_instance.vm_terr_w1_t2.network_interface.0.nat_ip_address}
#      User ${var.vm_user_name}
#      IdentityFile ~/.ssh/ssh-key
#  EOF
#  filename = "~/.ssh/config"
#}

resource "random_password" "random_string" {
  count = 2
  length      = 16
  special     = true
  min_upper   = 4
  min_lower   = 4
  min_numeric = 3
}

resource "docker_image" "mysql" {
  name = "mysql:8"
  keep_locally = true
}

resource "docker_container" "mysql1" {
  image = docker_image.mysql.image_id
  name = "mysql1"
  env = [
    "MYSQL_ROOT_PASSWORD=${random_password.random_string[0].result}",
    "MYSQL_DATABASE=wordpress",
    "MYSQL_USER=wordpress",
    "MYSQL_PASSWORD=${random_password.random_string[1].result}",
    "MYSQL_ROOT_HOST=%"
  ]

  ports {
    internal = 3306
    external = 3306
  }
}
