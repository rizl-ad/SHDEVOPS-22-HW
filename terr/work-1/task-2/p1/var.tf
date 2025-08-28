variable "yc_token" {
    type = string
    sensitive = true
}

variable "yc_cloud_id" {
    type = string
    sensitive = true
}

variable "yc_folder_id" {
    type = string
    sensitive = true
}

variable "yc_compute_default_zone" {
    type = string
}

variable "vm_user_name" {
    type = string
    sensitive = true
}

variable "pub_ssh_key" {
    type = string
    sensitive = true  
}
