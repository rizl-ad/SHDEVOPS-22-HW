resource "local_file" "index_html" {
  content = templatefile(
    "${path.module}/index.tftpl", {
        title = var.title
        hostname = var.hostname
        h1 = var.h1
    }
  )
  filename = "${path.module}/index.html"
}

output "local_file_index_html" {
  value = local_file.index_html.content
}