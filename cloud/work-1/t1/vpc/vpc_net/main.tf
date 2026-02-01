resource "yandex_vpc_network" "network" {
  name = var.net_name
}

output "network_id" {
  value = yandex_vpc_network.network.id
}