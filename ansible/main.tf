terraform {
  required_providers {
    virtualbox = {
      source  = "terra-farm/virtualbox"
      version = "0.3.2" # dernière version stable pour Windows
    }
  }
}

provider "virtualbox" {}

resource "virtualbox_vm" "vm1" {
  name   = "vm1"
  image  = "bento/ubuntu-20.04"
  cpus   = 2
  memory = 2048
  network_adapter {
    type           = "hostonly"
    host_interface = "vboxnet0"
  }
}

resource "virtualbox_vm" "vm2" {
  name   = "vm2"
  image  = "bento/ubuntu-20.04"
  cpus   = 2
  memory = 2048
  network_adapter {
    type           = "hostonly"
    host_interface = "vboxnet0"
  }
}