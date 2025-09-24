resource "yandex_container_registry" "cr" {
  name = var.cr_name
  folder_id = var.folder_id
  labels = var.cr_labels
}

output "cr_id" {
  value = yandex_container_registry.cr.id
}