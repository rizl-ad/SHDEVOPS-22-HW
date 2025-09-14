###cloud vars

locals {
  public_key = file("~/.ssh/pub-ssh-key")
}

variable "vm_user_name" {
  type = string
  sensitive = true
}

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