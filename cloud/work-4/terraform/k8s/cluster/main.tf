resource "yandex_kubernetes_cluster" "kubernetes_cluster" {
  cluster_ipv4_range = var.cluster_ipv4_range
  cluster_ipv6_range = var.cluster_ipv6_range
  description = var.description
  folder_id = var.folder_id
  labels = var.labels
  name = var.name
  network_id = var.network_id
  network_policy_provider = var.network_policy_provider
  node_ipv4_cidr_mask_size = var.node_ipv4_cidr_mask_size
  node_service_account_id = var.node_service_account_id
  release_channel = var.release_channel
  service_account_id = var.service_account_id
  service_ipv4_range = var.service_ipv4_range
  service_ipv6_range = var.service_ipv6_range

  dynamic "kms_provider" {
    for_each = var.kms_provider != null ? [1] : []
    content {
      key_id = var.kms_provider.key_id
    }
  }

  dynamic "master" {
    for_each = var.master != null ? [1] : []
    content {
      etcd_cluster_size = var.master.etcd_cluster_size
      external_v6_address = var.master.external_v6_address
      public_ip = var.master.public_ip
      security_group_ids = var.master.security_group_ids
      version = var.master.version

      dynamic "maintenance_policy" {
        for_each = var.master.maintenance_policy != null ? [1] : []
        content {
          auto_upgrade = var.master.maintenance_policy.auto_upgrade

          dynamic "maintenance_window" {
            for_each = var.master.maintenance_policy.maintenance_window != null ? [1] : []
            content {
              day = var.master.maintenance_policy.maintenance_window.day
              duration = var.master.maintenance_policy.maintenance_window.duration
              start_time = var.master.maintenance_policy.maintenance_window.start_time
            }
          }
        }
      }

      dynamic "master_location" {
        for_each = var.master.master_location != null ? [1] : []
        content {
          subnet_id = var.master.master_location.subnet_id
          zone = var.master.master_location.zone
        }
      }

      dynamic "master_logging" {
        for_each = var.master.master_logging != null ? [1] : []
        content {
          audit_enabled = var.master.master_logging.audit_enabled
          cluster_autoscaler_enabled = var.master.master_logging.cluster_autoscaler_enabled
          enabled = var.master.master_logging.enabled
          events_enabled = var.master.master_logging.events_enabled
          folder_id = var.master.master_logging.folder_id
          kube_apiserver_enabled = var.master.master_logging.kube_apiserver_enabled
          log_group_id = var.master.master_logging.log_group_id
        }
      }

      dynamic "regional" {
        for_each = var.master.regional != null ? [1] : []
        content {
          region = var.master.regional.region

          dynamic "location" {
            for_each = var.master.regional.location.subnet_ids != null ? var.master.regional.location.subnet_ids : []
            content {
              subnet_id = location.value
              zone = var.master.regional.location.zones[location.key]
            }
          }
        }
      }

      dynamic "scale_policy" {
        for_each = var.master.scale_policy != null ? [1] : []
        content {
          dynamic "auto_scale" {
            for_each = var.master.scale_policy.auto_scale != null ? [1] : []
            content {
              min_resource_preset_id = var.master.scale_policy.auto_scale.min_resource_preset_id
            }
          }
        }
      }

      dynamic "zonal" {
        for_each = var.master.zonal != null ? [1] : []
        content {
          subnet_id = var.master.zonal.subnet_id
          zone = var.master.zonal.zone
        }
      }
    }
  }

  dynamic "network_implementation" {
    for_each = var.network_implementation != null ? [1] : []
    content {
      dynamic "cilium" {
        for_each = var.network_implementation.cilium != null ? [1] : []
        content {}
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
  value = yandex_kubernetes_cluster.kubernetes_cluster.created_at
}

output "health" {
  value = yandex_kubernetes_cluster.kubernetes_cluster.health
}

output "id" {
  value = yandex_kubernetes_cluster.kubernetes_cluster.id
}

output "log_group_id" {
  value = yandex_kubernetes_cluster.kubernetes_cluster.log_group_id
}

output "status" {
  value = yandex_kubernetes_cluster.kubernetes_cluster.status
}

output "master_cluster_ca_certificate" {
  value = yandex_kubernetes_cluster.kubernetes_cluster.master[0].cluster_ca_certificate
}

output "master_external_v4_address" {
  value = yandex_kubernetes_cluster.kubernetes_cluster.master[0].external_v4_address
}

output "master_external_v4_endpoint" {
  value = yandex_kubernetes_cluster.kubernetes_cluster.master[0].external_v4_endpoint
}

output "master_external_v6_endpoint" {
  value = yandex_kubernetes_cluster.kubernetes_cluster.master[0].external_v6_endpoint
}

output "master_internal_v4_address" {
  value = yandex_kubernetes_cluster.kubernetes_cluster.master[0].internal_v4_address
}

output "master_internal_v4_endpoint" {
  value = yandex_kubernetes_cluster.kubernetes_cluster.master[0].internal_v4_endpoint
}

output "master_version_info" {
  value = yandex_kubernetes_cluster.kubernetes_cluster.master[0].version_info
}

output "workload_identity_federation_issuer" {
  value = yandex_kubernetes_cluster.kubernetes_cluster.workload_identity_federation[*].issuer
}

output "workload_identity_federation_jwks_uri" {
  value = yandex_kubernetes_cluster.kubernetes_cluster.workload_identity_federation[*].jwks_uri
}

