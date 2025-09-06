###cloud vars
# variable "token" {
#   type        = string
#   description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
#   sensitive = true
# }

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

variable "vm_user_name" {
  type = string
  sensitive = true
}

locals {
  pub_ssh_key = file("~/.ssh/pub-ssh-key")
}

variable "vm_params" {
  type = object({
    vm_name = map(string),
    vm_platform = map(string),
    vm_preemptible = list(bool),
    vm_cores = list(number),
    vm_core_fraction = list(number),
    vm_memory = list(number),
    vm_disk_image_id = map(string),
    vm_disk_size = list(number),
    vm_disk_type = map(string),
    vm_nat = list(bool),
    vm_sg = string
  })
  default = {
      vm_name = {
        web = "vm-terr-w3-t2-web",
        db = "vm-terr-w3-t2-db",
        stor = "vm-terr-w3-t2-storage",
      },
      vm_platform = {
        v2 = "standard-v2",
        v3 = "standard-v3"
      },
      vm_preemptible = [false,true]
      vm_cores = [2, 4],
      vm_core_fraction = [5,20,50,100]
      vm_memory = [1,2,4],
      vm_disk_image_id = {
        ubuntu_2404 = "fd8hjrk74m4jvmvl5gi6" # Ubuntu 24.04 LTS
      },
      vm_disk_size = [1,10,12],
      vm_disk_type = {
        hdd = "network-hdd"
      },
      vm_nat = [false,true]
      vm_sg = "example_dynamic"
  }
}

