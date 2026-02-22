variable "metadata" {
  type = object({
    name = optional(string)
    namespace = optional(string)
    labels = optional(map(string))
    annotations = optional(map(string))
    generate_name = optional(string)
  })
  default = null
}

variable "spec" {
  type = object({

    replicas = optional(number)
    min_ready_seconds = optional(number)
    paused = optional(bool)
    progress_deadline_seconds = optional(number)
    revision_history_limit = optional(number)

    selector = object({
      match_labels = optional(map(string))
      match_expressions = optional(list(object({
        key = optional(string)
        operator = optional(string)
        values = optional(list(string))
      })))
    })

    strategy = optional(object({
      type = optional(string)
      rolling_update = optional(object({
        max_surge = optional(string)
        max_unavailable = optional(string)
      }))
    }))

    template = object({

      metadata = object({
        labels = optional(map(string))
        annotations = optional(map(string))
      })

      spec = object({

        active_deadline_seconds = optional(number)
        automount_service_account_token = optional(bool)
        dns_policy = optional(string)
        enable_service_links = optional(bool)
        host_network = optional(bool)
        node_name = optional(string)
        priority_class_name = optional(string)
        restart_policy = optional(string)
        scheduler_name = optional(string)
        service_account_name = optional(string)
        share_process_namespace = optional(bool)
        termination_grace_period_seconds = optional(number)
        node_selector = optional(map(string))

        image_pull_secrets = optional(list(object({
          name = optional(string)
        })))

        container = list(object({

          name = string
          image = optional(string)
          image_pull_policy = optional(string)
          command = optional(list(string))
          args = optional(list(string))
          working_dir = optional(string)
          stdin = optional(bool)
          stdin_once = optional(bool)
          tty = optional(bool)

          port = optional(list(object({
            container_port = number
            host_ip = optional(string)
            host_port = optional(number)
            name = optional(string)
            protocol = optional(string)
          })))

          env = optional(list(object({
            name = string
            value = optional(string)
          })))

          env_from = optional(list(object({
            prefix = optional(string)
          })))

          resources = optional(object({
            limits = optional(map(string))
            requests = optional(map(string))
          }))

          volume_mount = optional(list(object({
            mount_path = optional(string)
            name = optional(string)
            read_only = optional(bool)
            sub_path = optional(string)
          })))

        }))

        volume = optional(list(object({
          name = optional(string)
        })))

        toleration = optional(list(object({
          key = optional(string)
          operator = optional(string)
          value = optional(string)
          effect = optional(string)
          toleration_seconds = optional(number)
        })))

      })
    })
  })
}