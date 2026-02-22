resource "yandex_kubernetes_node_group" "kubernetes_node_group" {
  allowed_unsafe_sysctls = var.allowed_unsafe_sysctls
  cluster_id = var.cluster_id
  description = var.description
  labels = var.labels
  name = var.name
  node_labels = var.node_labels
  node_taints = var.node_taints
  version = var.k8s_version

  dynamic "allocation_policy" {
    for_each = var.allocation_policy != null ? [1] : []
    content {
      dynamic "location" {
        for_each = var.allocation_policy.location != null ? [1] : []
        content {
          # subnet_id = var.allocation_policy.location.subnet_id    # depricated, use instance_template.network_interface.subnet_ids
          zone = var.allocation_policy.location.zone
        }
      }
    }
  }

  dynamic "deploy_policy" {
    for_each = var.deploy_policy != null ? [1] : []
    content {
      max_expansion = var.deploy_policy.max_expansion
      max_unavailable = var.deploy_policy.max_unavailable
    }
  }

  instance_template {
    labels = var.instance_template.labels
    metadata = var.instance_template.metadata
    name = var.instance_template.name != null ? "${var.instance_template.name}-{instance.index}" : null
    # nat = var.instance_template.nat   # depricated, use instance_template.network_interface.nat
    network_acceleration_type = var.instance_template.network_acceleration_type
    platform_id = var.instance_template.platform_id

    dynamic "boot_disk" {
      for_each = var.instance_template.boot_disk != null ? [1] : []
      content {
        size = var.instance_template.boot_disk.size
        type = var.instance_template.boot_disk.type
      }
    }

    dynamic "container_network" {
      for_each = var.instance_template.container_network != null ? [1] : []
      content {
        pod_mtu = var.instance_template.container_network.pod_mtu
      }
    }

    dynamic "container_runtime" {
      for_each = var.instance_template.container_runtime != null ? [1] : []
      content {
        type = var.instance_template.container_runtime.type
      }
    }

    dynamic "gpu_settings" {
      for_each = var.instance_template.gpu_settings != null ? [1] : []
      content {
        gpu_cluster_id = var.instance_template.gpu_settings.gpu_cluster_id
        gpu_environment = var.instance_template.gpu_settings.gpu_environment
      }
    }

    dynamic "network_interface" {
      for_each = var.instance_template.network_interface != null ? [1] : []
      content {
        ipv4 = var.instance_template.network_interface.ipv4
        ipv6 = var.instance_template.network_interface.ipv6
        nat = var.instance_template.network_interface.nat
        security_group_ids = var.instance_template.network_interface.security_group_ids
        subnet_ids = var.instance_template.network_interface.subnet_ids

        dynamic "ipv4_dns_records" {
          for_each = var.instance_template.network_interface.ipv4_dns_records != null ? [1] : []
          content {
            dns_zone_id = var.instance_template.network_interface.ipv4_dns_records.dns_zone_id
            fqdn = var.instance_template.network_interface.ipv4_dns_records.fqdn
            ptr = var.instance_template.network_interface.ipv4_dns_records.ptr
            ttl = var.instance_template.network_interface.ipv4_dns_records.ttl
          }
        }

        dynamic "ipv6_dns_records" {
          for_each = var.instance_template.network_interface.ipv6_dns_records != null ? [1] : []
          content {
            dns_zone_id = var.instance_template.network_interface.ipv6_dns_records.dns_zone_id
            fqdn = var.instance_template.network_interface.ipv6_dns_records.fqdn
            ptr = var.instance_template.network_interface.ipv6_dns_records.ptr
            ttl = var.instance_template.network_interface.ipv6_dns_records.ttl
          }
        }
      }
    }

    dynamic "placement_policy" {
      for_each = var.instance_template.placement_policy != null ? [1] : []
      content {
        placement_group_id = var.instance_template.placement_policy.placement_group_id
      }
    }

    dynamic "resources" {
      for_each = var.instance_template.resources != null ? [1] : []
      content {
        core_fraction = var.instance_template.resources.core_fraction
        cores = var.instance_template.resources.cores
        gpus = var.instance_template.resources.gpus
        memory = var.instance_template.resources.memory
      }
    }

    dynamic "scheduling_policy" {
      for_each = var.instance_template.scheduling_policy != null ? [1] : []
      content {
        preemptible = var.instance_template.scheduling_policy.preemptible
      }
    }
  }

  dynamic "maintenance_policy" {
    for_each = var.maintenance_policy != null ? [1] : []
    content {
      auto_repair = var.maintenance_policy.auto_repair
      auto_upgrade = var.maintenance_policy.auto_upgrade

      dynamic "maintenance_window" {
        for_each = var.maintenance_policy.maintenance_window != null ? [1] : []
        content {
          day = var.maintenance_policy.maintenance_window.day
          duration = var.maintenance_policy.maintenance_window.duration
          start_time = var.maintenance_policy.maintenance_window.start_time
        }
      }
    }
  }

  scale_policy {

    dynamic "auto_scale" {
      for_each = var.scale_policy.auto_scale != null ? [1] : []
      content {
        initial = var.scale_policy.auto_scale.initial
        max = var.scale_policy.auto_scale.max
        min = var.scale_policy.auto_scale.min
      }
    }

    dynamic "fixed_scale" {
      for_each = var.scale_policy.fixed_scale != null ? [1] : []
      content {
        size = var.scale_policy.fixed_scale.size
      }
    }
  }

  dynamic "workload_identity_federation" {
    for_each = var.workload_identity_federation != null ? [1] : []
    content {
      enabled = var.workload_identity_federation.enabled
    }
  }
}

output "created_at" {
  value = yandex_kubernetes_node_group.kubernetes_node_group.created_at
}

output "id" {
  value = yandex_kubernetes_node_group.kubernetes_node_group.id
}

output "instance_group_id" {
  value = yandex_kubernetes_node_group.kubernetes_node_group.instance_group_id
}

output "status" {
  value = yandex_kubernetes_node_group.kubernetes_node_group.status
}

output "version_info" {
  value = yandex_kubernetes_node_group.kubernetes_node_group.version_info
}