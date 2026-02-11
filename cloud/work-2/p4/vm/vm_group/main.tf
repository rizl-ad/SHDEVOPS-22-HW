resource "yandex_compute_instance_group" "vm_group" {
  service_account_id = var.service_account_id
  deletion_protection = var.deletion_protection
  description = var.description
  folder_id = var.folder_id
  labels = var.labels
  max_checking_health_duration = var.max_checking_health_duration
  name = var.name
  variables = var.variables
  
  allocation_policy {
    zones = var.allocation_policy.zones

    dynamic "instance_tags_pool" {
      for_each = var.allocation_policy.instance_tags_pool != null ? [1] : []
      content {
        tags = var.allocation_policy.instance_tags_pool.tags
        zone = var.allocation_policy.instance_tags_pool.zone
      }
    }
  }

  deploy_policy {
    max_expansion = var.deploy_policy.max_expansion
    max_unavailable = var.deploy_policy.max_unavailable
    max_creating = var.deploy_policy.max_creating
    max_deleting = var.deploy_policy.max_deleting
    startup_duration = var.deploy_policy.startup_duration
    strategy = var.deploy_policy.strategy
  }

  instance_template {
    description = var.instance_template.description
    hostname = var.instance_template.hostname != null ? "${var.instance_template.hostname}-{instance.index}" : null
    labels = var.instance_template.labels
    metadata = var.instance_template.metadata
    name = var.name != null ? "${var.name}-{instance.index}" : null
    platform_id = var.instance_template.platform_id
    reserved_instance_pool_id = var.instance_template.reserved_instance_pool_id
    service_account_id = var.instance_template.service_account_id

    boot_disk {
      device_name = var.instance_template.boot_disk.device_name
      disk_id = var.instance_template.boot_disk.disk_id
      mode = var.instance_template.boot_disk.mode
      name = var.instance_template.boot_disk.name
      
      initialize_params {
        description = var.instance_template.boot_disk.initialize_params.description
        image_id = var.instance_template.boot_disk.initialize_params.image_id
        size = var.instance_template.boot_disk.initialize_params.size
        snapshot_id = var.instance_template.boot_disk.initialize_params.snapshot_id
        type = var.instance_template.boot_disk.initialize_params.type
      }
    }

    network_interface {
      ip_address = var.instance_template.network_interface.ip_address
      ipv4 = var.instance_template.network_interface.ipv4
      ipv6 = var.instance_template.network_interface.ipv6
      ipv6_address = var.instance_template.network_interface.ipv6_address
      nat = var.instance_template.network_interface.nat
      nat_ip_address = var.instance_template.network_interface.nat_ip_address
      network_id = var.instance_template.network_interface.network_id
      security_group_ids = var.instance_template.network_interface.security_group_ids
      subnet_ids = var.instance_template.network_interface.subnet_ids

      dynamic "dns_record" {
        for_each = var.instance_template.network_interface.dns_record != null ? [1] : []
        content {
          fqdn = var.instance_template.network_interface.dns_record.fqdn
          dns_zone_id = var.instance_template.network_interface.dns_record.dns_zone_id
          ptr = var.instance_template.network_interface.dns_record.ptr
          ttl = var.instance_template.network_interface.dns_record.ttl
        }
      }

      dynamic "ipv6_dns_record" {
        for_each = var.instance_template.network_interface.ipv6_dns_record != null  ? [1] : []
        content {
          fqdn = var.instance_template.network_interface.ipv6_dns_record.fqdn
          dns_zone_id = var.instance_template.network_interface.ipv6_dns_record.dns_zone_id
          ptr = var.instance_template.network_interface.ipv6_dns_record.ptr
          ttl = var.instance_template.network_interface.ipv6_dns_record.ttl
        }
      }

      dynamic "nat_dns_record" {
        for_each = var.instance_template.network_interface.nat_dns_record != null ? [1] : []
        content {
          fqdn = var.instance_template.network_interface.nat_dns_record.fqdn
          dns_zone_id = var.instance_template.network_interface.nat_dns_record.dns_zone_id
          ptr = var.instance_template.network_interface.nat_dns_record.ptr
          ttl = var.instance_template.network_interface.nat_dns_record.ttl
        }
      }
    }

    resources {
      cores = var.instance_template.resources.cores
      memory = var.instance_template.resources.memory
      core_fraction = var.instance_template.resources.core_fraction
      gpus = var.instance_template.resources.gpus
    }

    dynamic "filesystem" {
      for_each = var.instance_template.filesystem != null ? [1] : []
      content {
        filesystem_id = var.instance_template.filesystem.filesystem_id
        device_name = var.instance_template.filesystem.device_name
        mode = var.instance_template.filesystem.mode
      }
    }

    dynamic "metadata_options" {
      for_each = var.instance_template.metadata_options != null ? [1] : []
      content {
        aws_v1_http_endpoint = var.instance_template.metadata_options.aws_v1_http_endpoint
        aws_v1_http_token = var.instance_template.metadata_options.aws_v1_http_token
        gce_http_endpoint = var.instance_template.metadata_options.gce_http_endpoint
        gce_http_token = var.instance_template.metadata_options.gce_http_token
      }
    }

    dynamic "network_settings" {
      for_each = var.instance_template.network_settings != null ? [1] : []
      content {
        type = var.instance_template.network_settings.type
      }
    }

    dynamic "placement_policy" {
      for_each = var.instance_template.placement_policy != null ? [1] : []
      content {
        placement_group_id = var.instance_template.placement_policy.placement_group_id
      }
    }

    dynamic "scheduling_policy" {
      for_each = var.instance_template.scheduling_policy != null ? [1] : []
      content {
        preemptible = var.instance_template.scheduling_policy.preemptible
      }
    }

    dynamic "secondary_disk" {
      for_each = var.instance_template.secondary_disk != null ? [1] : []
      content {
        device_name = var.instance_template.secondary_disk.device_name
        disk_id = var.instance_template.secondary_disk.disk_id
        mode = var.instance_template.secondary_disk.mode
        name = var.instance_template.secondary_disk.name
        
        initialize_params {
          description = var.instance_template.secondary_disk.initialize_params.description
          image_id = var.instance_template.secondary_disk.initialize_params.image_id
          size = var.instance_template.secondary_disk.initialize_params.size
          snapshot_id = var.instance_template.secondary_disk.initialize_params.snapshot_id
          type = var.instance_template.secondary_disk.initialize_params.type
        }
      }
    }
  }

  scale_policy {
    
    dynamic "auto_scale" {
      for_each = var.scale_policy.auto_scale != null ? [1] : []
      content {
        initial_size = var.scale_policy.auto_scale.initial_size
        measurement_duration = var.scale_policy.auto_scale.measurement_duration
        auto_scale_type = var.scale_policy.auto_scale.auto_scale_type
        cpu_utilization_target = var.scale_policy.auto_scale.cpu_utilization_target
        max_size = var.scale_policy.auto_scale.max_size
        min_zone_size = var.scale_policy.auto_scale.min_zone_size
        stabilization_duration = var.scale_policy.auto_scale.stabilization_duration
        warmup_duration = var.scale_policy.auto_scale.warmup_duration
        
        dynamic "custom_rule" {
          for_each = var.scale_policy.auto_scale.custom_rule != null ? [1] : []
          content {
            metric_name = var.scale_policy.auto_scale.custom_rule.metric_name
            metric_type = var.scale_policy.auto_scale.custom_rule.metric_type
            rule_type = var.scale_policy.auto_scale.custom_rule.rule_type
            target = var.scale_policy.auto_scale.custom_rule.target
            folder_id = var.folder_id
            labels = var.scale_policy.auto_scale.custom_rule.labels
            service = var.scale_policy.auto_scale.custom_rule.service
          }
        }
      }
    }

    dynamic "fixed_scale" {
      for_each = var.scale_policy.fixed_scale != null ? [1] : []
      content {
        size = var.scale_policy.fixed_scale.size
      }
    }

    dynamic "test_auto_scale" {
      for_each = var.scale_policy.test_auto_scale != null? var.scale_policy.test_auto_scale ? [1] : [] : []
      content {
        initial_size = var.scale_policy.auto_scale.initial_size
        measurement_duration = var.scale_policy.auto_scale.measurement_duration
        auto_scale_type = var.scale_policy.auto_scale.auto_scale_type
        cpu_utilization_target = var.scale_policy.auto_scale.cpu_utilization_target
        max_size = var.scale_policy.auto_scale.max_size
        min_zone_size = var.scale_policy.auto_scale.min_zone_size
        stabilization_duration = var.scale_policy.auto_scale.stabilization_duration
        warmup_duration = var.scale_policy.auto_scale.warmup_duration
        
        dynamic "custom_rule" {
          for_each = var.scale_policy.auto_scale.custom_rule != null ? [1] : []
          content {
            metric_name = var.scale_policy.auto_scale.custom_rule.metric_name
            metric_type = var.scale_policy.auto_scale.custom_rule.metric_type
            rule_type = var.scale_policy.auto_scale.custom_rule.rule_type
            target = var.scale_policy.auto_scale.custom_rule.target
            folder_id = var.folder_id
            labels = var.scale_policy.auto_scale.custom_rule.labels
            service = var.scale_policy.auto_scale.custom_rule.service
          }
        }
      }
    }
  }

  dynamic "application_load_balancer" {
    for_each = var.application_load_balancer != null ? [1] : []
    content {
      ignore_health_checks = var.application_load_balancer.ignore_health_checks
      max_opening_traffic_duration = var.application_load_balancer.max_opening_traffic_duration
      target_group_description = var.application_load_balancer.target_group_description
      target_group_labels = var.application_load_balancer.target_group_labels
      target_group_name = var.application_load_balancer.target_group_name
    }
  }

  dynamic "health_check" {
    for_each = var.health_check != null ?  [1] : []
    content {
      healthy_threshold = var.health_check.healthy_threshold
      interval = var.health_check.interval
      timeout = var.health_check.timeout
      unhealthy_threshold = var.health_check.unhealthy_threshold

      dynamic "http_options" {
        for_each = var.health_check.http_options != null ? [1] : []
        content {
          path = var.health_check.http_options.path
          port = var.health_check.http_options.port
        }
      }

      dynamic "tcp_options" {
        for_each = var.health_check.tcp_options != null ? [1] : []
        content {
          port = var.health_check.tcp_options.port
        }
      }

    }
  }

  dynamic "load_balancer" {
    for_each = var.load_balancer != null ? [1] : []
    content {
      ignore_health_checks = var.load_balancer.ignore_health_checks
      max_opening_traffic_duration = var.load_balancer.max_opening_traffic_duration
      target_group_description = var.load_balancer.target_group_description
      target_group_labels = var.load_balancer.target_group_labels
      target_group_name = var.load_balancer.target_group_name
    }
  }

  dynamic "timeouts" {
    for_each = var.timeouts != null ? [1] : []
    content {
      create = var.timeouts.create
      delete = var.timeouts.delete
      update = var.timeouts.update
    }
  }

}

output "created_at" {
  value = yandex_compute_instance_group.vm_group.created_at
}

output "id" {
  value = yandex_compute_instance_group.vm_group.id
}

output "instances" {
  value = yandex_compute_instance_group.vm_group.instances
}

output "status" {
  value = yandex_compute_instance_group.vm_group.status
}

output "application_load_balancer_status_message" {
  value = yandex_compute_instance_group.vm_group.application_load_balancer[*].status_message
}

output "application_load_balancer_target_group_id" {
  value = yandex_compute_instance_group.vm_group.application_load_balancer[*].target_group_id
}

output "load_balancer_status_message" {
  value = yandex_compute_instance_group.vm_group.load_balancer[*].status_message
}

output "load_balancer_target_group_id" {
  value = yandex_compute_instance_group.vm_group.load_balancer[*].target_group_id
}