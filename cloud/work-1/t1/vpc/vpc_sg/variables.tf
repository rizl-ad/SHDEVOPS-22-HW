variable "folder_id" {
  type = string
}

variable "security_group_name" {
  type = string
}

variable "network_id" {
  type = string
}

variable "security_group_ingress" {
  type = list(object(
    {
      protocol = string
      description = string
      v4_cidr_blocks = list(string)
      port = optional(number)
      from_port = optional(number)
      to_port = optional(number)
  }))
  default = [
    {
      protocol = "ANY"
      description = "Any allow"
      v4_cidr_blocks = ["0.0.0.0/0"]
      from_port = 0
      to_port = 65535
    }
  ]
}

variable "security_group_egress" {
  type = list(object(
    {
      protocol = string
      description = string
      v4_cidr_blocks = list(string)
      port = optional(number)
      from_port = optional(number)
      to_port = optional(number)
  }))
  default = [
    { 
      protocol = "ANY"
      description = "Any allow"
      v4_cidr_blocks = ["0.0.0.0/0"]
      from_port = 0
      to_port = 65535
    }
  ]
}