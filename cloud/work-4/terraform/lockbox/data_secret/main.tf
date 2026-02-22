data "yandex_lockbox_secret" "lockbox_secret" {
  name = var.name
  secret_id = var.secret_id
}

output "id" {
  value = data.yandex_lockbox_secret.lockbox_secret.id
}