variable "cr_name" {
  type = string
}

variable "folder_id" {
  type = string
}

variable "cr_labels" {
  type = map(string)
  default = null
}