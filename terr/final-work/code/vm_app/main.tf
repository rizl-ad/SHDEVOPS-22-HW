resource "yandex_compute_instance" "app" {
  count = var.vm_count
  name = "${var.vm_name}${format("%02d", count.index + 1)}"
  hostname = "${var.vm_name}${format("%02d", count.index + 1)}"
  platform_id = var.vm_platform
  service_account_id = var.vm_service_account_id

  scheduling_policy {
    preemptible = var.vm_preemptible
  }

  resources {
    cores = var.vm_cores
    core_fraction = var.vm_core_fraction
    memory = var.vm_memory
  }

  boot_disk {
    initialize_params {
      image_id = var.vm_disk_image_id
      size = var.vm_disk_size
      type = var.vm_disk_type
    }
  }

  network_interface {
    subnet_id = var.subnet_ids[count.index]
    nat = var.vm_public_ip
    security_group_ids = var.vm_security_group_ids
  }

  labels = var.vm_labels

  metadata = var.vm_metadata
}

output "vm_app_ip" {
  value = [ for i in yandex_compute_instance.app : var.vm_public_ip ? i.network_interface[0].nat_ip_address : i.network_interface[0].ip_address]
}