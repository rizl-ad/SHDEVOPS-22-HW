
module "test-vm" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name       = "develop" 
  network_id     = data.terraform_remote_state.vpc.outputs.network_id
  subnet_zones   = [data.terraform_remote_state.vpc.outputs.subnets[0].zone]
  subnet_ids     = [data.terraform_remote_state.vpc.outputs.subnets[0].id]
  instance_name  = "webs"
  instance_count = 2
  image_family   = "ubuntu-2004-lts"
  public_ip      = true

  labels = { 
    project = "marketing"
  }

  metadata = {
    user-data = local_file.cloud_init.content
    serial-port-enable = 1
  }
}

module "example-vm" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name       = "stage"
  network_id     = data.terraform_remote_state.vpc.outputs.network_id
  subnet_zones   = [data.terraform_remote_state.vpc.outputs.subnets[1].zone]
  subnet_ids     = [data.terraform_remote_state.vpc.outputs.subnets[1].id]
  instance_name  = "web-stage"
  instance_count = 1
  image_family   = "ubuntu-2004-lts"
  public_ip      = true

  labels = { 
    project = "analytics"
  }

  metadata = {
    user-data = local_file.cloud_init.content
    serial-port-enable = 1
  }
}

data "terraform_remote_state" "vpc" {
  backend = "local"
  config = {
    path = "../vpc/terraform.tfstate"
  }
}
