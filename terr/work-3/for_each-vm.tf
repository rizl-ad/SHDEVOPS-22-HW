resource "yandex_compute_instance" "db" {
  for_each = {
    1 = "main",
    0 = "replica"
  }
  name = "${var.vm_params.vm_name.db}-${each.value}"
  hostname = "${var.vm_params.vm_name.db}-${each.value}"
  platform_id = var.vm_params.vm_platform.v3

  scheduling_policy {
    preemptible = var.vm_params.vm_preemptible[1]
  }

  resources {
    cores = var.vm_params.vm_cores[each.key]
    core_fraction = var.vm_params.vm_core_fraction[1]
    memory = var.vm_params.vm_memory[each.key + 1]
  }

  boot_disk {
    initialize_params {
      image_id = var.vm_params.vm_disk_image_id.ubuntu_2404
      size = var.vm_params.vm_disk_size[each.key + 1]
      type = var.vm_params.vm_disk_type.hdd
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat = var.vm_params.vm_nat[0]
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