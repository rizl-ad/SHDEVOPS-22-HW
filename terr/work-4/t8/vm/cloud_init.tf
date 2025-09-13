resource "local_file" "cloud_init" {
  content = templatefile(
    "./cloud_init.tftpl", {
        user_name = var.vm_user_name
        pub_ssh_key = local.public_key
    }
  )
  filename = "./cloud-init.yaml"
}