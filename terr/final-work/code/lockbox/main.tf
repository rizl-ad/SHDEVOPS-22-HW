resource "yandex_lockbox_secret" "secret" {
  folder_id = var.folder_id
  name = var.name
  deletion_protection = var.deletion_protection

  password_payload_specification {
    password_key = var.password_key
    include_digits = var.include_digits
    include_lowercase = var.include_lowercase
    include_uppercase = var.include_uppercase
    include_punctuation = var.include_punctuation
    included_punctuation = "!#$%&?@[]^"
    length = var.length
  }
}

resource "yandex_lockbox_secret_version" "secret_version" {
  secret_id = yandex_lockbox_secret.secret.id
}

data "yandex_lockbox_secret_version" "secret_version" {
  secret_id  = yandex_lockbox_secret.secret.id
  version_id = yandex_lockbox_secret_version.secret_version.id
}

output "secret_value" {
  value = data.yandex_lockbox_secret_version.secret_version.entries[0].text_value
  #sensitive = true
}