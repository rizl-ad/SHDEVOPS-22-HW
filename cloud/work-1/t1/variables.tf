variable "vm_user_name" {
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
  default = "vpc-cloud-w1-t1"
}

locals {
  subnets = [
    { name = "public", zone = "ru-central1-a", v4_cidr = ["192.168.10.0/24"], route_table_id = null },
    { name = "private", zone = "ru-central1-b", v4_cidr = ["192.168.20.0/24"], route_table_id = module.route_table.route_table_id },
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

variable "vm_disk_image_id" {
  type = map(string)
  default = {
    Ubuntu2404 = "fd8hjrk74m4jvmvl5gi6" # Ubuntu 24.04 LTS
    Debian12 = "fd82i5dfjmt29385or2j" # Debian 12
    CentOS7 = "fd8ql4tgjlnrj1rh6q8l" # CentOS 7
    CentOSStream8 = "fd8qfp90a5l0m3d2htrm" # CentOS Stream 8
    CentOSStream9 = "fd8mh2vtfqnq4jcjqhjd" # CentOS Stream 9
    NAT-instance =  "fd80mrhj8fl2oe87o4e1" # NAT-инстанс Ubuntu 18.04
  }
}