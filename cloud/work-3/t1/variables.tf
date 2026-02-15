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

variable "bucket_name" {
  type = string
  default = "cloud-w1-t1-bucket"
}

variable "bucket_object" {
  type = string
  default = "/home/rizl/Screenshots/Screenshot from 2026-02-03 21-00-32.png"
}

variable "symmetric_key_name" {
  type = string
  default = "cloud-w3-t1-key"
}
