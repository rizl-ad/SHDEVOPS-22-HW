module "vpc_net" {
  source = "./vpc/vpc_net"
  net_name = var.network_name
}

module "route_table" {
  source = "./vpc/route_table"
  network_id = module.vpc_net.network_id
  rt_name = "vm-cloud-w1-t1-rt"
  dst_prefix = "0.0.0.0/0"
  next_hop_addr = var.nat_private_ip_addr
}

module "vpc_subnet" {
  source = "./vpc/vpc_subnet"
  network_id = module.vpc_net.network_id
  subnets = local.subnets
}

module "sg_ingress_vpc_local_only" {
  source = "./vpc/vpc_sg"
  security_group_name = "nat"
  folder_id = var.folder_id
  network_id = module.vpc_net.network_id
  security_group_ingress = local.sg_rule_vpc_local_only_allow
}

module "vm_nat_instance" {
  source = "./vm"
  vm_count = 1
  vm_user_name = var.vm_user_name
  vm_subnet_ids = [ module.vpc_subnet.subnets[0].id ]
  vm_zones = [ module.vpc_subnet.subnets[0].zone ]
  vm_names = [ "vm-cloud-w1-t1-nat" ]
  vm_disk_image_id = var.vm_disk_image_id.NAT-instance
  vm_private_ips = [ "${var.nat_private_ip_addr}" ]
  vm_public_ip = true
  vm_security_group_ids = [ module.sg_ingress_vpc_local_only.vpc_security_group_id ]
  vm_labels = {
    project = var.project_name
    owner = var.vm_user_name
  }
  vm_metadata = {
    user-data = module.vm_nat_instance.local_file_cloud_init
  }
  # run_cmd = [
  #   "sudo apt update",
  #   ""
  # ]
}

module "vm_public_ip" {
  source = "./vm"
  vm_count = 1
  vm_user_name = var.vm_user_name
  vm_subnet_ids = [ module.vpc_subnet.subnets[0].id ]
  vm_zones = [ module.vpc_subnet.subnets[0].zone ]
  vm_names = [ "vm-cloud-w1-t1-public-ip" ]
  vm_public_ip = true
  vm_labels = {
    project = var.project_name
    owner = var.vm_user_name
  }
  vm_metadata = {
    user-data = module.vm_nat_instance.local_file_cloud_init
  }
}

module "vm_private_ip" {
  source = "./vm"
  vm_count = 1
  vm_user_name = var.vm_user_name
  vm_subnet_ids = [ module.vpc_subnet.subnets[1].id ]
  vm_zones = [ module.vpc_subnet.subnets[1].zone ]
  vm_names = [ "vm-cloud-w1-t1-private-ip" ]
  vm_labels = {
    project = var.project_name
    owner = var.vm_user_name
  }
  vm_metadata = {
    user-data = module.vm_nat_instance.local_file_cloud_init
  }
}

output "vm_ip_adressess" {
  value = {
    vm-cloud-w1-t1-nat = module.vm_nat_instance.vm_ips
    vm-cloud-w1-t1-public-ip = module.vm_public_ip.vm_ips
    vm-cloud-w1-t1-private-ip = module.vm_private_ip.vm_ips
  }
}