resource "yandex_compute_disk" "vm_disk" {
  count = 3
  name = "vm-disk${count.index+1}"
  size = var.vm_params.vm_disk_size[0]
  type = var.vm_params.vm_disk_type.hdd
}

resource "yandex_compute_instance" "storage" {
  name = "${var.vm_params.vm_name.stor}"
  hostname = "${var.vm_params.vm_name.stor}"
  platform_id = var.vm_params.vm_platform.v2

  scheduling_policy {
    preemptible = var.vm_params.vm_preemptible[1]
  }

  resources {
    cores = var.vm_params.vm_cores[0]
    core_fraction = var.vm_params.vm_core_fraction[0]
    memory = var.vm_params.vm_memory[0]
  }

  boot_disk {
    initialize_params {
      image_id = var.vm_params.vm_disk_image_id.ubuntu_2404
      size = var.vm_params.vm_disk_size[1]
      type = var.vm_params.vm_disk_type.hdd
    }
  }

  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.vm_disk
    content {
      disk_id = secondary_disk.value.id
      auto_delete = true
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat = var.vm_params.vm_nat[1]
    security_group_ids = [ yandex_vpc_security_group.example.id ]
  }

  metadata = { 
    user-data = <<-EOF
      #cloud-config
      users:
      - name: ${var.vm_user_name}
        groups: sudo
        shell: /bin/bash
        sudo: 'ALL=(ALL) NOPASSWD:ALL'
        ssh_authorized_keys:
        - ${local.pub_ssh_key}
    EOF
  }
}