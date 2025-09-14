terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">=1.8.4"

  backend "s3" {
    endpoints = {
      s3 = "https://storage.yandexcloud.net"
      dynamodb = "https://docapi.serverless.yandexcloud.net/ru-central1/b1gsd0ucq8m5ueprd369/etnmjtq7nt33ps3q0tp6"
    }

    dynamodb_table = "tf-backend-table"
    
    shared_credentials_files = ["~/.aws/credentials"]
    profile = "yc_s3"
    region = "ru-central1"
    bucket = "terr-w4-t6-bucket-lb8iyecj"
    key = "shdevops-22/terr/w5-t2/terraform.tfstate"

    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true # This option is required for Terraform 1.6.1 or higher.
    skip_s3_checksum            = true # This option is required to describe a backend for Terraform 1.6.3 or higher.
  }
}

provider "yandex" {
  cloud_id = var.cloud_id
  folder_id = var.folder_id
  service_account_key_file = file("~/.ssh/.authorized_key.json")
  zone = var.default_zone
}
