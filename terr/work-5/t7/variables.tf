locals {
  public_key = file("~/.ssh/pub-ssh-key")
}

variable "cloud_id" { # значение в непубликуемом crd.auto.tfvars
  description = "Yandex Cloud ID"
  type = string
}

variable "folder_id" { # значение в непубликуемом crd.auto.tfvars
  description = "Yandex Cloud folder ID" 
  type = string
}

variable "default_zone" {
  description = "Yandex Cloud default zone"
  type = string
  default = "ru-central1-a"
}

variable "ydb_database_name" {
  description = "Name of the YDB database"
  type = string
  default = "terr-w5-t7-db"
}

variable "ydb_table_name" {
  description = "Name of the YDB table to store tflock"
  type = string
  default = "terr-w5-t7-table"
}

variable "bucket_name" {
  description = "Name of the Object Storage bucket to store tfstate"
  type = string
  default = "terr-w5-t7-bucket"
}

variable "service_account_name" {
  description = "Name of the service account"
  type = string
  default = "terr-w5-t7-svcacc"
}

variable "kms_symmetric_key_name" { # значение в непубликуемом crd.auto.tfvars
  type = string
  description = "Yandex KMS symmetric key"
}

variable "profile" {
  type = string
  default = "w5_t7"
}