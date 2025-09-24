resource "local_file" "cloud_init" {
  content = templatefile(
    "${path.module}/cloud_init.tftpl", {
        user_name = var.vm_user_name
        pub_ssh_key = local.pub_ssh_key
        run_cmd = var.run_cmd
    }
  )
  filename = "${path.module}/cloud-init.yaml"
}

output "local_file_cloud_init" {
  value = local_file.cloud_init.content
}