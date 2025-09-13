resource "null_resource" "vault_provision" {

    provisioner "local-exec" {
      environment = {
        VAULT_TOKEN = var.vault_token
      }
      command = "docker compose up -d"
      on_failure = fail
    }
  
}