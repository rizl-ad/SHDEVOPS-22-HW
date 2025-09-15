resource "yandex_iam_service_account" "terr_w5_t7_svcacc" {
  name = var.service_account_name
  folder_id = var.folder_id
}

resource "yandex_iam_service_account_static_access_key" "terr_w5_t7_svcacc_os_key" {
  service_account_id = yandex_iam_service_account.terr_w5_t7_svcacc.id
}

resource "local_sensitive_file" "aws_crd" {
  content = templatefile(
    "./aws_crd.tftpl", {
        profile = var.profile
        id = yandex_iam_service_account_static_access_key.terr_w5_t7_svcacc_os_key.access_key
        sec = yandex_iam_service_account_static_access_key.terr_w5_t7_svcacc_os_key.secret_key
    }
  )
  file_permission = "0600"
  filename = "./credentials"
}

resource "yandex_iam_service_account_iam_binding" "svcacc_permissions" {
  service_account_id = yandex_iam_service_account.terr_w5_t7_svcacc.id
  role = "viewer"
  members = [ "serviceAccount:${yandex_iam_service_account.terr_w5_t7_svcacc.id}" ]
}

data "yandex_kms_symmetric_key" "kms_symmetric_key" { # используется существующий KMS ключ
  name = var.kms_symmetric_key_name
}

resource "yandex_storage_bucket" "terr_w5_t7_bucket" {
  bucket = var.bucket_name
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = data.yandex_kms_symmetric_key.kms_symmetric_key.id
        sse_algorithm = "aws:kms"
      }
    }
  }
  versioning {
    enabled = true
  }
}

resource "yandex_storage_bucket_iam_binding" "bucket_permission" {
  bucket = yandex_storage_bucket.terr_w5_t7_bucket.bucket
  role = "editor"
  members = [ "serviceAccount:${yandex_iam_service_account.terr_w5_t7_svcacc.id}" ]
}

resource "yandex_ydb_database_serverless" "terr_w5_t7_ydb" {
  name = var.ydb_database_name
  deletion_protection = true
  serverless_database {
    storage_size_limit = 1
  }
}

# resource "aws_dynamodb_table" "terr_w5_t7_ydb_table" {
#   name = var.ydb_table_name
#   attribute {
#     name = "LockID"
#     type = "S"
#   }
# }