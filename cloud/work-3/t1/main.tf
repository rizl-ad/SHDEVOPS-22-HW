module "symmetric_key" {
  source = "./kms/symmetric/key"
  name = var.symmetric_key_name
  default_algorithm = "AES_256"
  deletion_protection = true
  rotation_period = "2160h"
}

module "bucket" {
  source = "./s3/bucket"
  bucket_name = var.bucket_name
  # access_read_bucket_objects = true
  versioning = true
  kms_master_key_id = module.symmetric_key.id
}

module "storage_object" {
  depends_on = [ module.bucket ]
  source = "./s3/object"
  bucket_name = var.bucket_name
  content_type = "image/png"
  object_key = "hw/cloud/w2/screenshot.png"
  source_object = var.bucket_object
}

output "storage_object_url" {
  value = "https://storage.yandexcloud.net/${var.bucket_name}/${module.storage_object.storage_object_key}"
}
