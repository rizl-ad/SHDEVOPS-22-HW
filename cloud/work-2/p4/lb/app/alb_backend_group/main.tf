resource "yandex_alb_backend_group" "alb_backend_group" {
  description = var.description
  folder_id = var.folder_id
  labels = var.labels
  name = var.name

  dynamic "grpc_backend" {
    for_each = var.grpc_backend != null ? [1] : []
    content {
      name = var.grpc_backend.name
      port = var.grpc_backend.port
      target_group_ids = var.grpc_backend.target_group_ids
      weight = var.grpc_backend.weight
      
      dynamic "healthcheck" {
        for_each = var.grpc_backend.healthcheck != null ? [1] : []
        content {
          healthcheck_port = var.grpc_backend.healthcheckhealthcheck_port
          healthy_threshold = var.grpc_backend.healthcheck.healthy_threshold
          interval = var.grpc_backend.healthcheck.interval
          interval_jitter_percent = var.grpc_backend.healthcheckinterval_jitter_percent
          timeout = var.grpc_backend.healthcheck.timeout
          unhealthy_threshold = var.grpc_backend.healthcheckunhealthy_threshold
          
          dynamic "grpc_healthcheck" {
            for_each = var.grpc_backend.healthcheck.grpc_healthcheck != null ? [1] : []
            content {
              service_name = var.grpc_backend.healthcheck.grpc_healthcheck.service_name
            }
          }

          dynamic "http_healthcheck" {
            for_each = var.grpc_backend.healthcheck.http_healthcheck != null ? [1] : []
            content {
              expected_statuses = var.grpc_backend.healthcheck.http_healthcheck.expected_statuses
              host = var.grpc_backend.healthcheck.http_healthcheck.host
              path = var.grpc_backend.healthcheck.http_healthcheck.path
              http2 = var.grpc_backend.healthcheck.http_healthcheck.http2
            }
          }

          dynamic "stream_healthcheck" {
            for_each = var.grpc_backend.healthcheck.stream_healthcheck != null ? [1] : []
            content {
              receive = var.grpc_backend.healthcheck.stream_healthcheck.receive
              send = var.grpc_backend.healthcheck.stream_healthcheck.send
            }
          }
        }
      }

      dynamic "load_balancing_config" {
        for_each = var.grpc_backend.load_balancing_config != null ? [1] : []
        content {
          locality_aware_routing_percent = var.grpc_backend.load_balancing_configlocality_aware_routing_percent
          mode = var.grpc_backend.load_balancing_config.mode
          panic_threshold = var.grpc_backend.load_balancing_config.panic_threshold
          strict_locality = var.grpc_backend.load_balancing_config.strict_locality
        }
      }

      dynamic "tls" {
        for_each = var.grpc_backend.tls != null ? [1] : []
        content {
          sni = var.grpc_backend.tls.sni

          dynamic "validation_context" {
            for_each = var.grpc_backend.tls.validation_context != null ? [1] : []
            content {
              trusted_ca_bytes = var.grpc_backend.tls.validation_context.trusted_ca_bytes
              trusted_ca_id = var.grpc_backend.tls.validation_context.trusted_ca_id
            }
          }
        }
      }

    }
  }
  
  dynamic "http_backend" {
    for_each = var.http_backend != null ? [1] : []
    content {
      http2 = var.http_backend.http2
      name = var.http_backend.name
      port = var.http_backend.port
      storage_bucket = var.http_backend.storage_bucket
      target_group_ids = var.http_backend.target_group_ids
      weight = var.http_backend.weight

      dynamic "healthcheck" {
        for_each = var.http_backend.healthcheck != null ? [1] : []
        content {
          healthcheck_port = var.http_backend.healthcheck.healthcheck_port
          healthy_threshold = var.http_backend.healthcheck.healthy_threshold
          interval = var.http_backend.healthcheck.interval
          interval_jitter_percent = var.http_backend.healthcheck.interval_jitter_percent
          timeout = var.http_backend.healthcheck.timeout
          unhealthy_threshold = var.http_backend.healthcheck.unhealthy_threshold
          
          dynamic "grpc_healthcheck" {
            for_each = var.http_backend.healthcheck.grpc_healthcheck != null ? [1] : []
            content {
              service_name = var.http_backend.healthcheck.grpc_healthcheck.service_name
            }
          }

          dynamic "http_healthcheck" {
            for_each = var.http_backend.healthcheck.http_healthcheck != null ? [1] : []
            content {
              expected_statuses = var.http_backend.healthcheck.http_healthcheck.expected_statuses
              host = var.http_backend.healthcheck.http_healthcheck.host
              http2 = var.http_backend.healthcheck.http_healthcheck.http2
              path = var.http_backend.healthcheck.http_healthcheck.path
            }
          }

          dynamic "stream_healthcheck" {
            for_each = var.http_backend.healthcheck.stream_healthcheck != null ? [1] : []
            content {
              receive = var.http_backend.healthcheck.stream_healthcheck.receive
              send = var.http_backend.healthcheck.stream_healthcheck.send
            }
          }
        }
      }
      
      dynamic "load_balancing_config" {
        for_each = var.http_backend.load_balancing_config != null ? [1] : []
        content {
          locality_aware_routing_percent = var.http_backend.load_balancing_config.locality_aware_routing_percent
          mode = var.http_backend.load_balancing_config.mode
          panic_threshold = var.http_backend.load_balancing_config.panic_threshold
          strict_locality = var.http_backend.load_balancing_config.strict_locality
        }
      }

      dynamic "tls" {
        for_each = var.http_backend.tls != null ? [1] : []
        content {
          sni = var.http_backend.tls.sni

          dynamic "validation_context" {
            for_each = var.http_backend.tls.validation_context != null ? [1] : []
            content {
              trusted_ca_bytes = var.http_backend.tls.validation_context.trusted_ca_bytes
              trusted_ca_id = var.http_backend.tls.validation_context.trusted_ca_id
            }
          }
        }
      }
    }
  }

  dynamic "session_affinity" {
    for_each = var.session_affinity != null ? [1] : []
    content {
      dynamic "connection" {
        for_each = var.session_affinity.connection != null ? [1] : []
        content {
          source_ip = var.session_affinity.connection.source_ip
        }
      }

      dynamic "cookie" {
        for_each = var.session_affinity.cookie != null ? [1] : []
        content {
          name = var.session_affinity.cookie.name
          path = var.session_affinity.cookie.path
          ttl = var.session_affinity.cookie.ttl
        }
      }

      dynamic "header" {
        for_each = var.session_affinity.header != null ? [1] : []
        content {
          header_name = var.session_affinity.header.header_name
        }
      }
    }
  }
  
  dynamic "stream_backend" {
    for_each = var.stream_backend != null ? [1] : []
    content {
      enable_proxy_protocol = var.stream_backend.enable_proxy_protocol
      keep_connections_on_host_health_failure = var.stream_backend.keep_connections_on_host_health_failure
      name = var.stream_backend.name
      port = var.stream_backend.port
      target_group_ids = var.stream_backend.target_group_ids
      weight = var.stream_backend.weight

      dynamic "healthcheck" {
        for_each = var.stream_backend.healthcheck != null ? [1] : []
        content {
          healthcheck_port = var.stream_backend.healthcheck.healthcheck_port
          healthy_threshold = var.stream_backend.healthcheck.healthy_threshold
          interval = var.stream_backend.healthcheck.interval  
          interval_jitter_percent = var.stream_backend.healthcheck.interval_jitter_percent
          timeout = var.stream_backend.healthcheck.timeout
          unhealthy_threshold = var.stream_backend.healthcheck.unhealthy_threshold

          dynamic "grpc_healthcheck" {
            for_each = var.stream_backend.healthcheck.grpc_healthcheck != null ? [1] : []
            content {
              service_name = var.stream_backend.healthcheck.grpc_healthcheck.service_name
            }
          }

          dynamic "http_healthcheck" {
            for_each = var.stream_backend.healthcheck.http_healthcheck != null ? [1] : []
            content {
              expected_statuses = var.stream_backend.healthcheck.http_healthcheck.expected_statuses
              host = var.stream_backend.healthcheck.http_healthcheck.host
              http2 = var.stream_backend.healthcheck.http_healthcheck.http2
              path = var.stream_backend.healthcheck.http_healthcheck.path
            }
          }

          dynamic "stream_healthcheck" {
            for_each = var.stream_backend.healthcheck.stream_healthcheck != null ? [1] : []
            content {
              receive = var.stream_backend.healthcheck.stream_healthcheck.receive
              send = var.stream_backend.healthcheck.stream_healthcheck.send
            }
          }
        }
      }

      dynamic "load_balancing_config" {
        for_each = var.stream_backend.load_balancing_config != null ? [1] : []
        content {
          locality_aware_routing_percent = var.stream_backend.load_balancing_config.locality_aware_routing_percent
          mode = var.stream_backend.load_balancing_config.mode
          panic_threshold = var.stream_backend.load_balancing_config.panic_threshold
          strict_locality = var.stream_backend.load_balancing_config.strict_locality
        }
      }

      dynamic "tls" {
        for_each = var.stream_backend.tls != null ? [1] : []
        content {
          sni = var.stream_backend.tls.sni

          dynamic "validation_context" {
            for_each = var.stream_backend.tls.validation_context != null ? [1] : []
            content {
              trusted_ca_bytes = var.stream_backend.tls.validation_context.trusted_ca_bytes
              trusted_ca_id = var.stream_backend.tls.validation_context.trusted_ca_id
            }
          }
        }
      }
    }
  }
}

output "created_at" {
  value = yandex_alb_backend_group.alb_backend_group.created_at
}

output "id" {
  value = yandex_alb_backend_group.alb_backend_group.id
}