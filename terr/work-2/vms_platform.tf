variable "vm_web_family" {
  type = string
  default = "ubuntu-2004-lts"
}

variable "vm_web_name" {
  type = string
  default = "netology-develop-platform-web"
}

variable "vm_db_name" {
  type = string
  default = "netology-develop-platform-db"
}

variable "vm_web_platform_id" {
  type = string
  default = "standard-v2"
}

# variable "vm_web_cores" {
#   type = number
#   default = 2
# }

# variable "vm_web_memory" {
#   type = number
#   default = 1
# }

# variable "vm_web_core_fraction" {
#   type = number
#   default = 5
# }

variable "vm_db_platform_id" {
  type = string
  default = "standard-v3"
}

# variable "vm_db_cores" {
#   type = number
#   default = 2
# }

# variable "vm_db_memory" {
#   type = number
#   default = 2
# }

# variable "vm_db_core_fraction" {
#   type = number
#   default = 20
# }

variable "vms_resources" {
  type = map(object({
    cores = number,
    memory = number,
    core_fraction = number
  }))
  default = {
    db = {
      cores = 2,
      memory = 2,
      core_fraction = 20
    },
    web = {
      cores = 2,
      memory = 1,
      core_fraction = 5
    }
  }
}

variable "vms_metadata" {
  type = map(object({
    serial_port_enable = number
    ssh_keys = string
  }))
  default = {
    metadata = {
      serial_port_enable = 1
      ssh_keys = "ubuntu:ssh-rsa AAAA..." # знаю что открытый ключ можно публиковать
    }
  }
}
