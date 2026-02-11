variable "acl" {
  type = string
  default = "private"
  description = "https://yandex.cloud/ru/docs/storage/concepts/acl#predefined_acls"
}

variable "bucket_name" {
  type = string
}

variable "object_key" {
  type = string
}

variable "content" {
  type = string
  default = null
}

variable "content_base64" {
  type = string
  default = null
}

variable "source_object" {
  type = string
  default = null
}

variable "source_object_hash" {
  type = string
  default = null
}

variable "tags" {
  type = map(string)
  default = null
  description = "https://yandex.cloud/ru/docs/storage/concepts/tags#object-tags"
}
