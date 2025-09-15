output "terr_w5_t7_ydb_api_endpoint" {
  value = yandex_ydb_database_serverless.terr_w5_t7_ydb.document_api_endpoint
}

output "s3_profile" {
  value = var.profile
}

output "terr_w5_t7_bucket" {
  value = yandex_storage_bucket.terr_w5_t7_bucket.bucket
}

output "keys_file" {
  value = "File with s3 credentials - ./credentials"
}