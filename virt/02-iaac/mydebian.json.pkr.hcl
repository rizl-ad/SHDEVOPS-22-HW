source "yandex" "debian_docker" {
  disk_type           = "network-hdd"
  folder_id           = "----folder_id----"
  image_description   = "my custom debian with docker"
  image_name          = "debian-12-docker"
  source_image_family = "debian-12"
  ssh_username        = "debian"
  subnet_id           = "----subnet_id----"
  token               = "----token----"
  use_ipv4_nat        = true
  zone                = "ru-central1-a"
}

build {
  sources = ["source.yandex.debian_docker"]

  provisioner "shell" {
    inline = [
      "curl -fsSL https://get.docker.com -o get-docker.sh",
      "sudo sh get-docker.sh",
      "sudo apt update",
      "sudo apt install -y htop tmux",
      "echo 'hello from packer'"
    ]
  }

}
