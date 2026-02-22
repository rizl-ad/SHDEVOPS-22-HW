resource "kubernetes_deployment_v1" "deployment" {

  dynamic "metadata" {
    for_each = var.metadata != null ? [var.metadata] : []
    content {
      name = metadata.value.name
      namespace = metadata.value.namespace
      labels = metadata.value.labels
      annotations = metadata.value.annotations
      generate_name = metadata.value.generate_name
    }
  }

  dynamic "spec" {
    for_each = var.spec != null ? [var.spec] : []
    content {

      replicas = spec.value.replicas
      min_ready_seconds = spec.value.min_ready_seconds
      paused = spec.value.paused
      progress_deadline_seconds = spec.value.progress_deadline_seconds
      revision_history_limit = spec.value.revision_history_limit

      dynamic "selector" {
        for_each = [spec.value.selector]
        content {
          match_labels = selector.value.match_labels

          dynamic "match_expressions" {
            for_each = selector.value.match_expressions != null ? selector.value.match_expressions : []
            content {
              key = match_expressions.value.key
              operator = match_expressions.value.operator
              values = match_expressions.value.values
            }
          }
        }
      }

      dynamic "strategy" {
        for_each = spec.value.strategy != null ? [spec.value.strategy] : []
        content {
          type = strategy.value.type

          dynamic "rolling_update" {
            for_each = strategy.value.rolling_update != null ? [strategy.value.rolling_update] : []
            content {
              max_surge = rolling_update.value.max_surge
              max_unavailable = rolling_update.value.max_unavailable
            }
          }
        }
      }

      dynamic "template" {
        for_each = [spec.value.template]
        content {

          dynamic "metadata" {
            for_each = [template.value.metadata]
            content {
              labels = metadata.value.labels
              annotations = metadata.value.annotations
            }
          }

          dynamic "spec" {
            for_each = [template.value.spec]
            content {

              active_deadline_seconds = spec.value.active_deadline_seconds
              automount_service_account_token = spec.value.automount_service_account_token
              dns_policy = spec.value.dns_policy
              enable_service_links = spec.value.enable_service_links
              host_network = spec.value.host_network
              node_name = spec.value.node_name
              priority_class_name = spec.value.priority_class_name
              restart_policy = spec.value.restart_policy
              scheduler_name = spec.value.scheduler_name
              service_account_name = spec.value.service_account_name
              share_process_namespace = spec.value.share_process_namespace
              termination_grace_period_seconds = spec.value.termination_grace_period_seconds
              node_selector = spec.value.node_selector

              dynamic "image_pull_secrets" {
                for_each = spec.value.image_pull_secrets != null ? spec.value.image_pull_secrets : []
                content {
                  name = image_pull_secrets.value.name
                }
              }

              dynamic "container" {
                for_each = spec.value.container
                content {

                  name = container.value.name
                  image = container.value.image
                  image_pull_policy = container.value.image_pull_policy
                  command = container.value.command
                  args = container.value.args
                  working_dir = container.value.working_dir
                  stdin = container.value.stdin
                  stdin_once = container.value.stdin_once
                  tty = container.value.tty

                  dynamic "port" {
                    for_each = container.value.port != null ? container.value.port : []
                    content {
                      container_port = port.value.container_port
                      host_ip = port.value.host_ip
                      host_port = port.value.host_port
                      name = port.value.name
                      protocol = port.value.protocol
                    }
                  }

                  dynamic "env" {
                    for_each = container.value.env != null ? container.value.env : []
                    content {
                      name = env.value.name
                      value = env.value.value
                    }
                  }

                  dynamic "env_from" {
                    for_each = container.value.env_from != null ? container.value.env_from : []
                    content {
                      prefix = env_from.value.prefix
                    }
                  }

                  dynamic "resources" {
                    for_each = container.value.resources != null ? [container.value.resources] : []
                    content {
                      limits = resources.value.limits
                      requests = resources.value.requests
                    }
                  }

                  dynamic "volume_mount" {
                    for_each = container.value.volume_mount != null ? container.value.volume_mount : []
                    content {
                      mount_path = volume_mount.value.mount_path
                      name = volume_mount.value.name
                      read_only = volume_mount.value.read_only
                      sub_path = volume_mount.value.sub_path
                    }
                  }

                }
              }

              dynamic "volume" {
                for_each = spec.value.volume != null ? spec.value.volume : []
                content {
                  name = volume.value.name
                }
              }

              dynamic "toleration" {
                for_each = spec.value.toleration != null ? spec.value.toleration : []
                content {
                  key = toleration.value.key
                  operator = toleration.value.operator
                  value = toleration.value.value
                  effect = toleration.value.effect
                  toleration_seconds = toleration.value.toleration_seconds
                }
              }

            }
          }

        }
      }

    }
  }

}

output "id" {
  value = kubernetes_deployment_v1.deployment.id
}

output "wait_for_rollout" {
  value = kubernetes_deployment_v1.deployment.wait_for_rollout
}

output "metadata" {
  value = kubernetes_deployment_v1.deployment.metadata
}

output "spec_template_metadata" {
  value = kubernetes_deployment_v1.deployment.spec[*].template[*].metadata
}