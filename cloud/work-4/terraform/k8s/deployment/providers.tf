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
}