variable "proxmox_endpoint" {
  type = string
  description = "Proxmox Endpoint"
}

variable "proxmox_username" {
  type = string
  description = "Proxmox UserName (When installing proxmox)"
}

variable "proxmox_password" {
  type = string
  sensitive = true
  description = "Password proxmox"
}
