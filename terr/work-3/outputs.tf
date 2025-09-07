output "vm_info" {
#   value = <<-EOF
#     %{for i in yandex_compute_instance.web}
#     "name"  = ${i.name}
#     "id"    = ${i.id}
#     "fqdn"  = ${i.fqdn}
#     %{endfor ~}
#     %{for i in yandex_compute_instance.db}
#     "name"  = ${i.name}
#     "id"    = ${i.id}
#     "fqdn"  = ${i.fqdn}
#     %{endfor ~}
#   EOF
  value = [
    [ for i in yandex_compute_instance.web : { 
      "name" = i.name,
      "id" = i.id,
      "fqdn" = i.fqdn,
    }],
    [ for i in yandex_compute_instance.db : { 
      "name" = i.name,
      "id" = i.id,
      "fqdn" = i.fqdn,
    }]
  ]
}