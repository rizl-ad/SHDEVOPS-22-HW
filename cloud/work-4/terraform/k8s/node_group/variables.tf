variable "allowed_unsafe_sysctls" {
  type = list(string)
  default = null
}

variable "cluster_id" {
  type = string
}

variable "description" {
  type = string
  default = null
}

variable "labels" {
  type = map(string)
  default = null
}

variable "name" {
  type = string
}

variable "node_labels" {
  type = map(string)
  default = null
}

variable "node_taints" {
  type = list(string)
  default = null
}

variable "k8s_version" {
  type = string
  default = null
}

variable "allocation_policy" {
  type = object({
    location = optional(object({
      # subnet_id = string   # depricated, use instance_template.network_interface.subnet_ids
      zone = string
    }))
  })
  default = null
}

variable "deploy_policy" {
  type = object({
    max_expansion = number
    max_unavailable = number
  })
  default = null
}

variable "instance_template" {
  type = object({
    labels = optional(map(string))
    metadata = optional(map(string))
    name = optional(string)
    # nat = optional(bool)  # depricated, use instance_template.network_interface.nat
    network_acceleration_type = optional(string)
    platform_id = optional(string, "standard-v2")

    boot_disk = optional(object({
      size = optional(number, 64)
      type = optional(string, "network-hdd")
    }))

    container_network = optional(object({
      pod_mtu = optional(number)
    }))

    container_runtime = optional(object({
      type = optional(string, "containerd")
    }))

    gpu_settings = optional(object({
      gpu_cluster_id = optional(string)
      gpu_environment = optional(string)
    }))

    network_interface = optional(object({
      ipv4 = optional(bool)
      ipv6 = optional(bool)
      nat = optional(bool)
      security_group_ids = optional(set(string))
      subnet_ids = set(string)

      ipv4_dns_records = optional(object({
        dns_zone_id = optional(string)
        fqdn = string
        ptr = optional(bool)
        ttl = optional(number)
      }))

      ipv6_dns_records = optional(object({
        dns_zone_id = optional(string)
        fqdn = string
        ptr = optional(bool)
        ttl = optional(number)
      }))
    }))

    placement_policy = optional(object({
      placement_group_id = string
    }))

    resources = optional(object({
      core_fraction = optional(number, 20)
      cores = optional(number, 2)
      gpus = optional(number)
      memory = optional(number,2)
    }))

    scheduling_policy = optional(object({
      preemptible = optional(bool, true)
    }))
  })
  validation {
    condition = var.instance_template.boot_disk != null != null ? contains(
      ["network-hdd", "network-ssd", "network-ssd-nonreplicated", "network-ssd-io-m3"], var.instance_template.boot_disk.type
    ) : true
    error_message = "Invalid k8s instance template disk type, see description link"
  }
  validation {
    condition = contains(["standard-v1", "standard-v2", "standard-v3", "amd-v1", "standard-v4a"], var.instance_template.platform_id)
    error_message = "Invalid k8s instance template platform, valid values: \"standard-v1\", \"standard-v2\", \"standard-v3\", \"amd-v1\", \"standard-v4a\""
  }
  validation {
    condition = var.instance_template.resources.cores % 2 == 0
    error_message = "Invalid k8s instance template cores count, value must be divisible by 2 without a remainder"
  }
  validation {
    condition = contains([5, 20, 50, 100], var.instance_template.resources.core_fraction)
    error_message = "Invalid k8s instance template core fraction, valid values: 5, 20, 50, 100"
  }
  description = "https://yandex.cloud/ru/docs/managed-kubernetes/concepts/#node-group"
}

variable "maintenance_policy" {
  type = object({
    auto_repair = bool
    auto_upgrade = bool

    maintenance_window = optional(object({
      day = optional(string)
      duration = string
      start_time = string
    }))
  })
  default = null
}

variable "scale_policy" {
  type = object({
    auto_scale = optional(object({
      initial = number
      max = number
      min = number
    }))

    fixed_scale = optional(object({
      size = optional(number)
    }))
  })
  validation {
    condition = (var.scale_policy.auto_scale != null) != (var.scale_policy.fixed_scale != null)
    error_message = "K8s nodes scale policy mast be either auto scale or fixed scale"
  }
}

variable "workload_identity_federation" {
  type = object({
    enabled = bool
  })
  default = null
}