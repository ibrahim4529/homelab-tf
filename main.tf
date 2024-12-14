terraform {
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
      version = "0.68.1"
    }
  }
}

provider "proxmox" {
  endpoint = var.proxmox_endpoint
  username = var.proxmox_username
  password = var.proxmox_password
}