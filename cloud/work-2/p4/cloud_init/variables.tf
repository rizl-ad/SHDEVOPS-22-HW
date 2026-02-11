variable "user_name" {
  type = string
  sensitive = true
}

variable "pub_ssh_key_path" {
  type = string
  sensitive = true
}

locals {
  pub_ssh_key = file(var.pub_ssh_key_path)
}

variable "cloud_init_files" {
  type = list(object({
    content = string
    path = string
    permissions = string
  }))
  default = null
}

variable "run_cmd" {
  type = list(string)
  default = []
}
