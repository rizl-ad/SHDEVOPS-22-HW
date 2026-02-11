resource "yandex_alb_load_balancer" "lb_app" {
  allow_zonal_shift = var.allow_zonal_shift
  description = var.description
  folder_id = var.folder_id
  labels = var.labels
  name = var.name
  network_id = var.network_id
  region_id = var.region_id
  security_group_ids = var.security_group_ids

  dynamic "allocation_policy" {
    for_each = var.allocation_policy != null ? [1] : []
    content {
      dynamic "location" {
        for_each = var.allocation_policy.location != null ? [1] : []
        content {
          disable_traffic = var.allocation_policy.location.disable_traffic
          subnet_id = var.allocation_policy.location.subnet_id
          zone_id = var.allocation_policy.location.zone_id
        }
      }
    }
  }

  dynamic "auto_scale_policy" {
    for_each = var.auto_scale_policy != null ? [1] : []
    content {
      max_size = var.auto_scale_policy.max_size
      min_zone_size = var.auto_scale_policy.min_zone_size
    }
  }

  dynamic "listener" {
    for_each = var.listener != null ? [1] : []
    content {
      name = var.listener.name

      dynamic "endpoint" {
        for_each = var.listener.endpoint != null ? [1] : []
        content {
          ports = var.listener.endpoint.ports

          dynamic "address" {
            for_each = var.listener.endpoint.address != null ? [1] : []
            content {
              
              dynamic "external_ipv4_address" {
                for_each = var.listener.endpoint.address.external_ipv4_address != null ? [1] : []
                content {
                  address = var.listener.endpoint.address.external_ipv4_address.address
                }
              }

              dynamic "external_ipv6_address" {
                for_each = var.listener.endpoint.address.external_ipv6_address != null ? [1] : []
                content {
                  address = var.listener.endpoint.address.external_ipv6_address.address
                }
              }

              dynamic "internal_ipv4_address" {
                for_each = var.listener.endpoint.address.internal_ipv4_address != null ? [1] : []
                content {
                  address = var.listener.endpoint.address.internal_ipv4_address.address
                  subnet_id = var.listener.endpoint.address.internal_ipv4_address.subnet_id
                }
              }
            }
          }
        }
      }

      dynamic "http" {
        for_each = var.listener.http != null ? [1] : []
        content {
          dynamic "handler" {
            for_each = var.listener.http.handler != null ? [1] : []
            content {
              allow_http10 = var.listener.http.handler.allow_http10
              http_router_id = var.listener.http.handler.http_router_id
              rewrite_request_id = var.listener.http.handler.rewrite_request_id

              dynamic "http2_options" {
                for_each = var.listener.http.handler.http2_options != null ? [1] : []
                content {
                   max_concurrent_streams = var.listener.http.handler.http2_options.max_concurrent_streams
                }
              }
            }
          }

          dynamic "redirects" {
            for_each = var.listener.http.redirects != null ? [1] : []
            content {
              http_to_https = var.listener.http.redirects.http_to_https
            }
          }
        }
      }

      dynamic "stream" {
        for_each = var.listener.stream != null ? [1] : []
        content {
          dynamic "handler" {
            for_each = var.listener.stream.handler != null ? [1] : []
            content {
              backend_group_id = var.listener.stream.handler.backend_group_id
              idle_timeout = var.listener.stream.handler.idle_timeout
            }
          }
        }
      }

      dynamic "tls" {
        for_each = var.listener.tls != null ? [1] : []
        content {
          dynamic "default_handler" {
            for_each = var.listener.tls.default_handler != null ? [1] : []
            content {
              certificate_ids = var.listener.tls.default_handler.certificate_ids

              dynamic "http_handler" {
                for_each = var.listener.tls.default_handler.http_handler != null ? [1] : []
                content {
                  allow_http10 = var.listener.tls.default_handler.http_handler.allow_http10
                  http_router_id = var.listener.tls.default_handler.http_handler.http_router_id
                  rewrite_request_id = var.listener.tls.default_handler.http_handler.rewrite_request_id

                  dynamic "http2_options" {
                    for_each = var.listener.tls.default_handler.http_handler.http2_options != null ? [1] : []
                    content {
                      max_concurrent_streams = var.listener.tls.default_handler.http_handler.http2_options.max_concurrent_streams
                    }
                  }
                }
              }

              dynamic "stream_handler" {
                for_each = var.listener.tls.default_handler.stream_handler != null ? [1] : []
                content {
                  backend_group_id = var.listener.tls.default_handler.stream_handler.backend_group_id
                  idle_timeout = var.listener.tls.default_handler.stream_handler.idle_timeout
                }
              }
            }
          }

          dynamic "sni_handler" {
            for_each = var.listener.tls.sni_handler != null ? [1] : []
            content {
              name = var.listener.tls.sni_handler.name
              server_names = var.listener.tls.sni_handler.server_names

              dynamic "handler" {
                for_each = var.listener.tls.sni_handler.handler != null ? [1] : []
                content {
                  certificate_ids = var.listener.tls.sni_handler.handler.certificate_ids

                  dynamic "http_handler" {
                    for_each = var.listener.tls.sni_handler.handler.http_handler != null ? [1] : []
                    content {
                      allow_http10 = var.listener.tls.sni_handler.handler.http_handler.allow_http10
                      http_router_id = var.listener.tls.sni_handler.handler.http_handler.http_router_id
                      rewrite_request_id = var.listener.tls.sni_handler.handler.http_handler.rewrite_request_id

                      dynamic "http2_options" {
                        for_each = var.listener.tls.sni_handler.handler.http_handler.http2_options != null ? [1] : []
                        content {
                          max_concurrent_streams = var.listener.tls.sni_handler.handler.http_handler.http2_options.max_concurrent_streams
                        }
                      }
                    }
                  }

                  dynamic "stream_handler" {
                    for_each = var.listener.tls.sni_handler.handler.stream_handler != null ? [1] : []
                    content {
                      backend_group_id = var.listener.tls.sni_handler.handler.stream_handler.backend_group_id
                      idle_timeout = var.listener.tls.sni_handler.handler.stream_handler.idle_timeout
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }

  dynamic "log_options" {
    for_each = var.log_options != null ? [1] : []
    content {
      disable = var.log_options.disable
      log_group_id = var.log_options.log_group_id

      dynamic "discard_rule" {
        for_each = var.log_options.discard_rule != null ? [1] : []
        content {
          discard_percent = var.log_options.discard_rule.discard_percent
          grpc_codes = var.log_options.discard_rule.grpc_codes
          http_code_intervals = var.log_options.discard_rule.http_code_intervals
          http_codes = var.log_options.discard_rule.http_codes
        }
      }
    }
  }
}

output "created_at" {
  value = yandex_alb_load_balancer.lb_app.created_at
}

output "id" {
  value = yandex_alb_load_balancer.lb_app.id
}

output "log_group_id" {
  value = yandex_alb_load_balancer.lb_app.log_group_id
}

output "status" {
  value = yandex_alb_load_balancer.lb_app.status
}

