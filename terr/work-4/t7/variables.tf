variable "cloud_id" {
  type = string
}

variable "folder_id" {
  type = string
}

variable "default_zone" {
  type = string
  default = "ru-central1-a"
}

variable "vault_token" {
  type = string
  sensitive = true
}

variable "vault_secret_key_value" {
  type = string
  sensitive = true
}