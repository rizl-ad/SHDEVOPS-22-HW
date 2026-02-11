variable "vm_user_name" {
  type = string
  sensitive = true
}

variable "pub_ssh_key_path" {
  type = string
  sensitive = true
}

variable "yc_token" {
  type = string
  sensitive = true
}

variable "cloud_id" {
  type = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type = string
  default = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "network_name" {
  type = string
  default = "cloud-w1-t1-vpc"
}

locals {
  subnets = [
    { name = "public", zone = "ru-central1-a", v4_cidr = ["192.168.10.0/24"], route_table_id = null },
    # { name = "private", zone = "ru-central1-b", v4_cidr = ["192.168.20.0/24"], route_table_id = module.route_table.route_table_id },
    { name = "private", zone = "ru-central1-b", v4_cidr = ["192.168.20.0/24"], route_table_id = null },
  ]
  sg_rule_vpc_local_only_allow = [
    {
      protocol = "ANY"
      description = "Any allow"
      v4_cidr_blocks = flatten(local.subnets[*].v4_cidr)
      from_port = 0
      to_port = 65535
    }
  ]
  cloud_init_files = [
    {
      content = module.index_html.local_file_index_html
      path = "/var/www/html/index.html"
      permissions = "0644"
    }
  ]
}

variable "nat_private_ip_addr" {
  type = string
  default = "192.168.10.254"
}

variable "project_name" {
  type = string
  default = "cloud-w1-t1"
}

variable "vm_service_account_id" {
  type = string
  sensitive = true
}

variable "vm_names" {
  type = list(string)
  default = ["vm-cloud-w1-t1"]
}

variable "vm_group_name" {
  type = string
  default = "vm-group-cloud-w2-t1"
}

variable "vm_disk_image_id" {
  type = map(string)
  default = {
    Ubuntu2404 = "fd8hjrk74m4jvmvl5gi6" # Ubuntu 24.04 LTS
    Debian12 = "fd82i5dfjmt29385or2j" # Debian 12
    CentOS7 = "fd8ql4tgjlnrj1rh6q8l" # CentOS 7
    CentOSStream8 = "fd8qfp90a5l0m3d2htrm" # CentOS Stream 8
    CentOSStream9 = "fd8mh2vtfqnq4jcjqhjd" # CentOS Stream 9
    NAT-instance1804 =  "fd80mrhj8fl2oe87o4e1" # NAT-инстанс Ubuntu 18.04
    LAMP = "fd827b91d99psvq5fjit" # LAMP
  }
}

variable "bucket_name" {
  type = string
  default = "cloud-w1-t1-bucket"
}

variable "vm_group_scale" {
  type = number
  default = 3
}

variable "lb_port" {
  type = number
  default = 80
}

variable "lb_net_name" {
  type = string
  default = "cloud-w2-t1-net-lb"
}

variable "lb_net_listener_name" {
  type = string
  default = "cloud-w2-t1-net-lb-listener"
}

variable "lb_net_listener_hc_name" {
  type = string
  default = "cloud-w2-t1-net-lb-listener-hc"
}

variable "lb_app_name" {
  type = string
  default = "cloud-w2-t1-app-lb"
}

variable "lb_app_listener_name" {
  type = string
  default = "cloud-w2-t1-app-lb-listener"
}

variable "alb_backend_group_name" {
  type = string
  default = "cloud-w2-t1-alb-bg"
}

variable "alb_backend_group_backend_name" {
  type = string
  default = "cloud-w2-t1-alb-bg-backend"
}