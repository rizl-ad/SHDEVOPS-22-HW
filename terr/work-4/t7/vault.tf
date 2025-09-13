provider "vault" {
  address = "http://127.0.0.1:8200"
  skip_tls_verify = true
  token = var.vault_token
}

resource "vault_generic_secret" "vault_example" {
  depends_on = [ null_resource.vault_provision ]
  path = "secret/example secret data"
  data_json = jsonencode({ "test_secret_data" = var.vault_secret_key_value })
}

data "vault_generic_secret" "vault_example"{
  depends_on = [ resource.vault_generic_secret.vault_example ]
  path = "secret/example secret data"
}

output "vault_example" {
  value = "${nonsensitive(data.vault_generic_secret.vault_example.data)}"
}