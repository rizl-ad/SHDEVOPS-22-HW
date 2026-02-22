terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = ">=0.158.0"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = ">=2.7.0"
    }
  }
  required_version = ">=1.13.0"

  backend "s3" {
    endpoints = {
      s3 = "https://storage.yandexcloud.net"
      dynamodb = "https://docapi.serverless.yandexcloud.net/ru-central1/b1gsd0ucq8m5ueprd369/etn1mq0ed18mh2517iq6"
    }

    dynamodb_table = "tf-backend-table"
    
    shared_credentials_files = ["~/.aws/credentials"]
    profile = "yc_s3"
    region = "ru-central1"
    bucket = "shdevops-22-bucket"
    key = "shdevops-22/cloud-w1-t1-bucket/terraform.tfstate"

    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true # This option is required for Terraform 1.6.1 or higher.
    skip_s3_checksum            = true # This option is required to describe a backend for Terraform 1.6.3 or higher.
  }
}

provider "yandex" {
  cloud_id = var.cloud_id
  folder_id = var.folder_id
  token = var.yc_token
  zone = var.default_zone
}

data "yandex_client_config" "client" {}

provider "kubernetes" {
  host = "https://${module.k8s_cluster.master_external_v4_address}"
  cluster_ca_certificate = module.k8s_cluster.master_cluster_ca_certificate
  token = data.yandex_client_config.client.iam_token
}