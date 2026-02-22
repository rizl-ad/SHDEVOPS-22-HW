resource "kubernetes_service_v1" "kubernetes_service" {

  dynamic "metadata" {
    for_each = var.metadata != null ? [var.metadata] : []
    content {
      name = metadata.value.name
      namespace = metadata.value.namespace
      annotations = metadata.value.annotations
      labels = metadata.value.labels
      generate_name = metadata.value.generate_name
    }
  }

  dynamic "spec" {
    for_each = var.spec != null ? [var.spec] : []
    content {
      cluster_ip = spec.value.cluster_ip
      cluster_ips = spec.value.cluster_ips
      external_ips = spec.value.external_ips
      external_name = spec.value.external_name
      external_traffic_policy = spec.value.external_traffic_policy
      health_check_node_port = spec.value.health_check_node_port
      internal_traffic_policy = spec.value.internal_traffic_policy
      ip_families = spec.value.ip_families
      ip_family_policy = spec.value.ip_family_policy
      load_balancer_class = spec.value.load_balancer_class
      load_balancer_ip = spec.value.load_balancer_ip
      load_balancer_source_ranges = spec.value.load_balancer_source_ranges
      publish_not_ready_addresses = spec.value.publish_not_ready_addresses
      selector = spec.value.selector
      session_affinity = spec.value.session_affinity
      type = spec.value.type

      dynamic "session_affinity_config" {
        for_each = spec.value.session_affinity_config != null ? [spec.value.session_affinity_config] : []
        content {

          dynamic "client_ip" {
            for_each = session_affinity_config.value.client_ip != null ? [session_affinity_config.value.client_ip] : []
            content {
              timeout_seconds = client_ip.value.timeout_seconds
            }
          }

        }
      }

      dynamic "port" {
        for_each = spec.value.port != null ? spec.value.port : []
        content {
          name = port.value.name
          port = port.value.port
          protocol = port.value.protocol
          target_port = port.value.target_port
          node_port = port.value.node_port
          app_protocol = port.value.app_protocol
        }
      }

    }
  }
}

output "id" {
  value = kubernetes_service_v1.kubernetes_service.id
}

output "metadata_generation" {
  value = kubernetes_service_v1.kubernetes_service.metadata[*].generation
}

output "metadata_resource_version" {
  value = kubernetes_service_v1.kubernetes_service.metadata[*].resource_version
}

output "metadata_uid" {
  value = kubernetes_service_v1.kubernetes_service.metadata[*].uid
}

output "status" {
  value = kubernetes_service_v1.kubernetes_service.status
}

output "load_balancer_ingress" {
  value = try(kubernetes_service_v1.kubernetes_service.status[*].load_balancer[*].ingress, null)
}

output "wait_for_load_balancer" {
  value = kubernetes_service_v1.kubernetes_service.wait_for_load_balancer
}
