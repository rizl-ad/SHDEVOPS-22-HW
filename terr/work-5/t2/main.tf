#создаем облачную сеть
# resource "yandex_vpc_network" "develop" {
#   name = "develop"
# }

# #создаем подсеть
# resource "yandex_vpc_subnet" "develop_a" {
#   name           = "develop-ru-central1-a"
#   zone           = "ru-central1-a"
#   network_id     = yandex_vpc_network.develop.id
#   v4_cidr_blocks = ["10.0.1.0/24"]
# }

# resource "yandex_vpc_subnet" "develop_b" {
#   name           = "develop-ru-central1-b"
#   zone           = "ru-central1-b"
#   network_id     = yandex_vpc_network.develop.id
#   v4_cidr_blocks = ["10.0.2.0/24"]
# }


module "test-vm" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=4d05fab828b1fcae16556a4d167134efca2fccf2"
  env_name       = "develop" 
  network_id     = module.vpc.network_id
  subnet_zones   = [module.vpc.subnets[0].zone]
  subnet_ids     = [module.vpc.subnets[0].id]
  security_group_ids = module.vpc.security_group_ids
  instance_name  = "webs"
  instance_count = 2
  image_family   = "ubuntu-2004-lts"
  public_ip      = false

  labels = { 
    project = "marketing"
  }

  metadata = {
    #user-data          = data.template_file.cloudinit.rendered #Для демонстрации №3
    user-data = local_file.cloud_init.content
    serial-port-enable = 1
  }
}

module "example-vm" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=4d05fab828b1fcae16556a4d167134efca2fccf2"
  env_name       = "stage"
  network_id     = module.vpc.network_id
  subnet_zones   = [module.vpc.subnets[1].zone]
  subnet_ids     = [module.vpc.subnets[1].id]
  security_group_ids = module.vpc.security_group_ids
  instance_name  = "web-stage"
  instance_count = 1
  image_family   = "ubuntu-2004-lts"
  public_ip      = false

  labels = { 
    project = "analytics"
  }

  metadata = {
    #user-data          = data.template_file.cloudinit.rendered #Для демонстрации №3
    user-data = local_file.cloud_init.content
    serial-port-enable = 1
  }
}

#Пример передачи cloud-config в ВМ для демонстрации №3
# data "template_file" "cloudinit" {
#   template = file("./cloud-init.yaml")
# }

module "vpc" {
  source = "./vpc"
  net_name = "terr-w4-t2"
  subnets = [
    {zone = "ru-central1-a", v4_cidr = ["10.0.10.0/24", "10.0.11.0/24", "10.0.12.0/24"]},
    {zone = "ru-central1-b", v4_cidr = ["10.0.20.0/24", "10.0.21.0/24"]},
    {zone = "ru-central1-d", v4_cidr = ["10.0.30.0/24", "10.0.31.0/24"]},
  ]
}

