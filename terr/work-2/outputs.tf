output "vm_info" {
  value = {
    "instance_name" = {
      value = {
        "VM web name" = yandex_compute_instance.platform.name
        "VM db name" = yandex_compute_instance.platform_db.name
      }
    }
    "external_ip" = {
      value = {
        "VM web public ip-address" = yandex_compute_instance.platform.network_interface.0.nat_ip_address
        "VM db public ip-address" = yandex_compute_instance.platform_db.network_interface.0.nat_ip_address
      }
    }
    "fqdn" = {
      value = {
        "VM web fqdn" = yandex_compute_instance.platform.fqdn
        "VM db fqdn" = yandex_compute_instance.platform_db.fqdn
      }
    }
  }
}