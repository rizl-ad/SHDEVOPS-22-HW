output "network_id" {
  value = yandex_vpc_network.network_terr_w4_t2.id
}

output "subnets" {
  value = yandex_vpc_subnet.subnet_terr_w4_t2[*]
}