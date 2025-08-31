###cloud vars


variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = list(string)
  default     = ["ru-central1-a", "ru-central1-b"]
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(list(string))
  default     = [["10.0.1.0/24"],["10.0.2.0/24"]]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}

variable "vpc_subnet_name" {
  type        = list(string)
  default     = ["develop-a", "develop-b"]
  description = "VPC network & subnet name"
}

###ssh vars

# variable "vms_ssh_root_key" {
#   type        = string
#   default     = "<your_ssh_ed25519_key>"
#   description = "ssh-keygen -t ed25519"
# }

# variable "vms_ssh_public_root_key" {
#   type = string
# }

variable "test" {}