resource "yandex_vpc_route_table" "rt" {
  network_id = var.network_id
  name = var.rt_name

  static_route {
    destination_prefix = var.dst_prefix
    gateway_id = var.gw_id
    next_hop_address = var.next_hop_addr
  }
}

output "route_table_id" {
  value = yandex_vpc_route_table.rt.id
}