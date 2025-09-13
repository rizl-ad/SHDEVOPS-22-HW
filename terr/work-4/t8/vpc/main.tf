resource "yandex_vpc_network" "network_terr_w4_t2" {
  name = "network-${var.net_name}"
}

resource "yandex_vpc_subnet" "subnet_terr_w4_t2" {
  count = length(var.subnets)
  name = "subnet-${var.net_name}-${count.index}"
  zone = var.subnets[count.index].zone
  network_id = yandex_vpc_network.network_terr_w4_t2.id
  v4_cidr_blocks = var.subnets[count.index].v4_cidr
}