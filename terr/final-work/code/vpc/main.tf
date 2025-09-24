resource "yandex_vpc_network" "network_terr_final" {
  name = "network-${var.net_name}"
}

resource "yandex_vpc_subnet" "subnet_terr_final" {
  count = length(var.subnets)
  name = "subnet-${var.net_name}-${count.index}"
  zone = var.subnets[count.index].zone
  network_id = yandex_vpc_network.network_terr_final.id
  v4_cidr_blocks = var.subnets[count.index].v4_cidr
}

output "network_id" {
  value = yandex_vpc_network.network_terr_final.id
}

output "subnets" {
  value = yandex_vpc_subnet.subnet_terr_final[*]
}