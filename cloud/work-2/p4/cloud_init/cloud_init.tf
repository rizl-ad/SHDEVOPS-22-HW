resource "random_string" "suffix" {
  length  = 5
  special = false
  upper   = false
}

resource "local_file" "cloud_init" {
  content = templatefile(
    "${path.module}/cloud_init.tftpl", {
        user_name = var.user_name
        pub_ssh_key = local.pub_ssh_key
        run_cmd = var.run_cmd
        files = var.cloud_init_files
    }
  )
  filename = "${path.module}/cloud-init-${random_string.suffix.result}.yaml"
}

output "local_file_cloud_init" {
  value = local_file.cloud_init.content
}