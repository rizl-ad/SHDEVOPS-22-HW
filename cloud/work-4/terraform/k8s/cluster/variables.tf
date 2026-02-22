variable "cluster_ipv4_range" {
  type = string
  default = null
  validation {
    condition = var.cluster_ipv4_range != null ? can(cidrhost(var.cluster_ipv4_range, 0)) && can(cidrnetmask(var.cluster_ipv4_range)) : true
    error_message = "K8s cluster IPv4 range must be a valid IPv4 CIDR-block"
  }
}

variable "cluster_ipv6_range" {
  type = string
  default = null
  validation {
    condition = var.cluster_ipv6_range != null ? can(cidrhost(var.cluster_ipv6_range, 0)) : true
    error_message = "K8s cluster IPv6 range must be a valid IPv6 CIDR-block"
  }
}

variable "description" {
  type = string
  default = null
}

variable "folder_id" {
  type = string
  default = null
}

variable "labels" {
  type = map(string)
  default = null
}

variable "name" {
  type = string
  default = null
}

variable "network_id" {
  type = string
}

variable "network_policy_provider" {
  type = string
  default = null
  validation {
    condition = var.network_policy_provider == null || var.network_policy_provider == "CALICO"
    error_message = "K8s network policy provider value mast be \"CALICO\""
  }
}

variable "node_ipv4_cidr_mask_size" {
  type = number
  default = null
}

variable "node_service_account_id" {
  type = string
}

variable "release_channel" {
  type = string
  default = "REGULAR"
  validation {
    condition = contains(["RAPID", "REGULAR", "STABLE"], var.release_channel)
    error_message = "K8s release chanel value mast be one of: \"RAPID\", \"REGULAR\", \"STABLE\""
  }
}

variable "service_account_id" {
  type = string
}

variable "service_ipv4_range" {
  type = string
  default = null
  validation {
    condition = var.service_ipv4_range != null ? can(cidrhost(var.service_ipv4_range, 0)) && can(cidrnetmask(var.service_ipv4_range)) : true
    error_message = "K8s service IPv4 range must be a valid IPv4 CIDR-block"
  }
}

variable "service_ipv6_range" {
  type = string
  default = null
  validation {
    condition = var.service_ipv6_range != null ? can(cidrhost(var.service_ipv6_range, 0)) : true
    error_message = "K8s service IPv6 range must be a valid IPv6 CIDR-block"
  }
}

variable "kms_provider" {
  type = object({
    key_id = string
  })
  default = null
}

variable "master" {
  type = object({
    etcd_cluster_size = optional(number)
    external_v6_address = optional(string)
    public_ip = optional(bool)
    security_group_ids = optional(set(string))
    version = optional(string)
    maintenance_policy = optional(object({
      auto_upgrade = bool
      maintenance_window = optional(object({
        day = optional(string)
        start_time = string
        duration = string
      }))
    }))
    master_location = optional(object({
      subnet_id = string
      zone = string
    }))
    master_logging = optional(object({
      audit_enabled = optional(bool)
      cluster_autoscaler_enabled = optional(bool)
      enabled = optional(bool)
      events_enabled = optional(bool)
      folder_id = optional(string)
      kube_apiserver_enabled = optional(bool)
      log_group_id = optional(string)
    }))
    regional = optional(object({
      region = optional(string, "ru-central1")
      location = object({
        subnet_ids = list(string)
        zones = list(string)
      })
    }))
    scale_policy = optional(object({
      auto_scale = optional(object({
        min_resource_preset_id = optional(string, "s-c2-m8")
      }))
    }))
    zonal = optional(object({
      subnet_id = string
      zone = string
    }))
  })
  validation {
    condition = var.master != null && var.master.external_v6_address != null ? can(cidrhost("${var.master.external_v6_address}/128", 0)) : true
    error_message = "K8s external IPv6 address must be a valid"
  }
  validation {
    condition = var.master != null && var.master.regional != null && var.master.regional.region != null ? contains(
      ["ru-central1"], var.master.regional.region
    ) : true
    error_message = "K8s master region invalid, valid values: \"ru-central1\""
  }
  validation {
    condition = (
      (var.master.master_location != null ? 1 : 0) +
      (var.master.regional != null ? 1 : 0) +
      (var.master.zonal != null ? 1 : 0)
    ) == 1
    error_message = "K8s cluster master must be either zonal or regional master or master_location should be specified"
  }
  validation {
    condition = var.master != null && var.master.scale_policy != null && var.master.regional.scale_policy.auto_scale != null ? contains(
      [
        "s-c2-m8", "s-c4-m16", "s-c8-m32", "s-c16-m64", "s-c32-m128", "s-c64-m256", "s-c80-m320", "c-c4-m8",
        "c-c8-m16", "c-c16-m32", "c-c32-m64", "m-c2-m16", "m-c4-m32", "m-c8-m64", "m-c16-m128", "m-c32-m256"
      ], var.master.regional.scale_policy.auto_scale.min_resource_preset_id
    ) : true
    error_message = "K8s master resource preset id invalid, see https://yandex.cloud/ru/docs/managed-kubernetes/concepts/#master-resources"
  }
  description = "https://yandex.cloud/ru/docs/managed-kubernetes/concepts/#master"
}

variable "network_implementation" {
  type = object({
    cilium = optional(object({}))
  })
  default = null
}

variable "workload_identity_federation" {
  type = object({
    enabled = bool
  })
  default = null
}