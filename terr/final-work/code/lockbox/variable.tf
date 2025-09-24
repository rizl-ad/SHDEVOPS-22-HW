variable "folder_id" {
  type = string
}

variable "name" {
  type = string
}

variable "password_key" {
  type = string
}

variable "include_digits" {
  type = bool
  default = true
}

variable "include_lowercase" {
  type = bool
  default = true
}

variable "include_uppercase" {
  type = bool
  default = true
}

variable "include_punctuation" {
  type = bool
  default = true
}

variable "included_punctuation" {
  type = string
  default = "!\"#$%&'()*+,-./:;<=>?@[\\]^_"
}

variable "length" {
  type = number
  default = 36
}

variable "deletion_protection" {
  type = bool
  default = false
}

