terraform {
  required_providers {
    proxmox = {
        source = "bpg/proxmox"
        version = "0.74.1"
    }
  }
}

provider "proxmox" {
  endpoint = var.proxmox_endpoint
  username    = var.proxmox_user
  password = var.proxmox_password
  insecure = true

  ssh {
    agent = true
  }
}
