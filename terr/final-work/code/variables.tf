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
  default = "vpc-terr-final-work"
}

variable "vm_app_name" {
  type = string
  default = "vm-terr-final-work-app"
}

variable "security_group_name" {
  type = string
  default = "sg-terr-final-work"
}

variable "db_name" {
  type = string
  default = "db_terr_final_work"
}

variable "db_user_name" {
  type = string
  default = "app"
}

variable "cr_name" {
  type = string
  default = "cr-terr-final-work"
}

variable "db_cluster_name" {
  type = string
  default = "db-cluster-terr-final-work"
}

variable "db_node_name" {
  type = string
  default = "db-node-terr-final-work"
}

variable "project_name" {
  type = string
  default = "terr-final-work"
}

variable "vm_service_account_id" {
  type = string
  sensitive = true
}

variable "secret_name" {
  type = string
  default = "db-pass-terr-final-work"
}

variable "secret_pass_key" {
  type = string
  default = "db_cluster_user_password"
}