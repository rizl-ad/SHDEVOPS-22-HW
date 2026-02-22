data "yandex_lockbox_secret_version" "lockbox_secret_version" {
  secret_id = var.secret_id
  version_id = var.version_id
}

output "id" {
  value = data.yandex_lockbox_secret_version.lockbox_secret_version.id
}

output "secret_value" {
  value = data.yandex_lockbox_secret_version.lockbox_secret_version.entries[0].text_value
  sensitive = true
}