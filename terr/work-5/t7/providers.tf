terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = ">= 0.158.0"
    }
  }
  required_version = ">=1.13.0"
}

provider "yandex" {
  cloud_id = var.cloud_id
  folder_id = var.folder_id
  service_account_key_file = file("~/.ssh/.authorized_key.json")
  zone = var.default_zone
}

# provider "aws" {
#   region = "ru-central1"
#   endpoints {
#     dynamodb = yandex_ydb_database_serverless.terr_w5_t7_ydb.ydb_api_endpoint
#   }

#   shared_credentials_files = [local_file.aws_crd.filename]
#   #profile = var.profile

#   skip_credentials_validation = true
#   skip_metadata_api_check = true
#   skip_region_validation = true
#   skip_requesting_account_id = true
# }