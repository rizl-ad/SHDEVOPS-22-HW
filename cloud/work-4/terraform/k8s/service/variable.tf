variable "metadata" {
  type = object({
    name = optional(string)
    namespace = optional(string)
    annotations = optional(map(string))
    labels = optional(map(string))
    generate_name = optional(string)
  })
}

variable "spec" {
  type = object({
    cluster_ip = optional(string)
    cluster_ips = optional(list(string))
    external_ips = optional(list(string))
    external_name = optional(string)
    external_traffic_policy = optional(string)
    health_check_node_port = optional(number)
    internal_traffic_policy = optional(string)
    ip_families = optional(list(string))
    ip_family_policy = optional(string)
    load_balancer_class = optional(string)
    load_balancer_ip = optional(string)
    load_balancer_source_ranges = optional(list(string))
    publish_not_ready_addresses = optional(bool)
    selector = optional(map(string))
    session_affinity = optional(string)
    type = optional(string)

    session_affinity_config = optional(object({
      client_ip = optional(object({
        timeout_seconds = optional(number)
      }))
    }))

    port = optional(list(object({
      name = optional(string)
      port = optional(number)
      protocol = optional(string)
      target_port = optional(string)
      node_port = optional(number)
      app_protocol = optional(string)
    })))
  })
}
