resource "local_file" "hosts" {
  content = templatefile(
    "./hosts_v2.tftpl", {
        vm_names = var.vm_params.vm_name
        vm_db = yandex_compute_instance.db
        vm_web = yandex_compute_instance.web
        vm_stor = yandex_compute_instance.storage
    }
  )
  filename = "./hosts"
}

#resource "local_file" "name" {
#  content = <<-EOF
#
#  EOF
#  filename = "~/file_name"
#}
