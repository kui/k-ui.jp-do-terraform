variable "env" {
}

provider "digitalocean" {
  token = "${file("./do_token")}"
}

resource "digitalocean_ssh_key" "default" {
  name = "Default SSH Key"
  public_key = "${file("./ssh/id_rsa.pub")}"
}

resource "digitalocean_droplet" "k-ui-jp" {
  image = "ubuntu-14-04-x64"
  name = "${var.env}.k-ui.jp"
  region = "sgp1"
  size = "512mb"
  ssh_keys = [
    "${digitalocean_ssh_key.default.fingerprint}"
  ]

  connection {
    user = "root"
    type = "ssh"
    key_file = "./ssh/id_rsa"
    timeout = "10m"
  }

  provisioner "file" {
    source = "./files/common/"
    destination = "/"
  }
  provisioner "file" {
    source = "./files/${var.env}/"
    destination = "/"
  }
  provisioner "file" {
    source = "./scripts"
    destination = "/root/tf-scripts"
  }

  provisioner "remote-exec" {
    inline = [
      "ENV=${var.env} bash /root/tf-scripts/kick.bash | tee -a /root/kick.log"
    ]
  }
}
