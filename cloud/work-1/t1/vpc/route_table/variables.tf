variable "rt_name" {
  type = string
  default = "route-table"
}

variable "network_id" {
  type = string
}

variable "dst_prefix" {
  type = string
}

variable "next_hop_addr" {
  type = string
  default = null
}

variable "gw_id" {
  type = string
  default = null
}