terraform {
  required_providers { 
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

resource "yandex_compute_instance" "vm_terr_w1_t2" {
  name = "vm-terr-w1-t2"
  hostname = "vm-terr-w1-t2"
  platform_id = "standard-v3"
  zone = "ru-central1-a"

  scheduling_policy {
    preemptible = true  # прерываемая ВМ
  }

  resources {
    cores = 2
    core_fraction = 20
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8hjrk74m4jvmvl5gi6" # Ubuntu 24.04 LTS
      size = 10
      type = "network-hdd"
    }
  }

  network_interface {
    subnet_id = "e9br58rb6bkvgo8vid0d"  # default-ru-central1-a
    nat = true
  }

  metadata = {
    #ssh-keys = "${var.vm_user_name}:${var.pub_ssh_key}"    
    user-data = <<-EOF
      #cloud-config
      users:
      - name: ${var.vm_user_name}
        groups: sudo
        shell: /bin/bash
        sudo: 'ALL=(ALL) NOPASSWD:ALL'
        ssh_authorized_keys:
        - ${var.pub_ssh_key}
    EOF
  }

  provisioner "remote-exec" {
    inline = [
      "curl -fsSL https://get.docker.com -o get-docker.sh",
      "sudo sh get-docker.sh",
      "sudo usermod -aG docker ${var.vm_user_name}"
    ]

    connection {
      type = "ssh"
      user = var.vm_user_name
      host = yandex_compute_instance.vm_terr_w1_t2.network_interface.0.nat_ip_address
      private_key = file("~/.ssh/ssh-key")
    }
  }
}
