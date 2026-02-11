resource "yandex_storage_object" "storage_object" {
  acl = var.acl
  bucket = var.bucket_name
  key = var.object_key
  content = var.content
  content_base64 = var.content_base64
  source = var.source_object
  source_hash = var.source_object_hash
  tags = var.tags
}

output "storage_object_id" {
  value = yandex_storage_object.storage_object.id
}

output "storage_object_key" {
  value = yandex_storage_object.storage_object.id
}