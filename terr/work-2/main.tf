resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}

resource "yandex_vpc_subnet" "develop" {
  count          = 2
  name           = var.vpc_subnet_name[count.index]
  zone           = var.default_zone[count.index]
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr[count.index]
  route_table_id = yandex_vpc_route_table.terr_w2_t9_rt.id
}

resource "yandex_vpc_gateway" "nat_gateway" {
  name = "ter-w2-t9-gateway"
  shared_egress_gateway {}
}

resource "yandex_vpc_route_table" "terr_w2_t9_rt" {
  name       = "ter-w2-t9-route-table"
  network_id = yandex_vpc_network.develop.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    gateway_id         = yandex_vpc_gateway.nat_gateway.id
  }
}

data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_family
}

resource "yandex_compute_instance" "platform" {
  name        = local.name_web
  platform_id = var.vm_web_platform_id
  resources {
    cores         = var.vms_resources.web.cores
    memory        = var.vms_resources.web.memory
    core_fraction = var.vms_resources.web.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop[0].id
    nat       = false
  }

  metadata = {
    serial-port-enable = var.vms_metadata.metadata.serial_port_enable
    ssh-keys           = var.vms_metadata.metadata.ssh_keys
  }
}

resource "yandex_compute_instance" "platform_db" {
  name        = local.name_db
  platform_id = var.vm_db_platform_id
  zone        = "ru-central1-b"
  resources {
    cores         = var.vms_resources.db.cores
    memory        = var.vms_resources.db.memory
    core_fraction = var.vms_resources.db.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop[1].id
    nat       = false
  }

  metadata = {
    serial-port-enable = var.vms_metadata.metadata.serial_port_enable
    ssh-keys           = var.vms_metadata.metadata.ssh_keys
  }
}
