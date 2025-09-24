variable "subnet_ids" {
  type = list(string)
}

variable "vm_user_name" {
  type = string
  sensitive = true
}

locals {
  pub_ssh_key = file("~/.ssh/pub-ssh-key")
}

variable "vm_count" {
  type = number
}

variable "vm_name" {
  type = string
}

variable "vm_platform" {
  type = string
  default = "standard-v2"
  description = "https://yandex.cloud/ru/docs/compute/concepts/performance-levels"
  validation {
    condition = contains(["standard-v1", "standard-v2", "standard-v3", "standard-v4a"], var.vm_platform)
    error_message = "Invalid VM platform, valid values: \"standard-v1\", \"standard-v2\", \"standard-v3\", \"standard-v4a\""
  }
}

variable "vm_preemptible" {
  type = bool
  default = true
  description = "https://yandex.cloud/ru/docs/compute/concepts/preemptible-vm"
}

variable "vm_cores" {
  type = number
  default = 2
  description = "https://yandex.cloud/ru/docs/compute/concepts/performance-levels"
  validation {
    condition = var.vm_cores % 2 == 0
    error_message = "Invalid VM cores count, value must be divisible by 2 without a remainder"
  }
}

variable "vm_core_fraction" {
  type = number
  default = 5
  description = "https://yandex.cloud/ru/docs/compute/concepts/performance-levels"
  validation {
    condition = contains([5, 20, 50, 100], var.vm_core_fraction)
    error_message = "Invalid VM core fraction, valid values: 5, 20, 50, 100"
  }
}

variable "vm_memory" {
  type = number
  default = 2
  description = "https://yandex.cloud/ru/docs/compute/concepts/performance-levels"
}

variable "vm_disk_image_id" {
  type = string
  default = "fd8hjrk74m4jvmvl5gi6" # Ubuntu 24.04 LTS
  description = "https://yandex.cloud/ru/docs/compute/concepts/image"
}

variable "vm_disk_size" {
  type = number
  default = 10
}

variable "vm_disk_type" {
  type = string
  default = "network-hdd"
  description = "https://yandex.cloud/ru/docs/compute/concepts/disk"
  validation {
    condition = contains(["network-hdd", "network-ssd", "network-ssd-nonreplicated", "network-ssd-io-m3"], var.vm_disk_type)
    error_message = "Invalid VM disk type, see description link"
  }
}

variable "vm_public_ip" {
  type = bool
  default = false
  description = "https://yandex.cloud/ru/docs/compute/concepts/network#public-ip"
}

variable "vm_security_group_ids" {
  type = list(string)
  default = null
  description = "https://yandex.cloud/ru/docs/vpc/concepts/security-groups"
}

variable "vm_labels" {
  type = map(string)
  default = null
  description = "https://yandex.cloud/ru/docs/resource-manager/concepts/labels"
}

variable "vm_metadata" {
  type = map(any)
  default = null
  description = "https://yandex.cloud/ru/docs/compute/concepts/vm-metadata"
}

variable "run_cmd" {
  type = list(string)
  default = null
}

variable "vm_service_account_id" {
  type = string
  default = null
}