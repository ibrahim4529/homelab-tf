variable "proxmox_endpoint" {
  description = "Proxmox endpoint URL"
  type        = string
}

variable "proxmox_user" {
  description = "Proxmox user"
  type        = string  
}

variable "proxmox_password" {
  description = "Proxmox password"
  type        = string
  sensitive   = true
}

variable "node_name" {
  description = "Proxmox node name"
  type        = string
  default     = "pve"
}

variable "container_name" {
  description = "Name of the LXC container"
  type        = string
  default     = "cloudflare-tunnel"
}

variable "container_password" {
  description = "Root password for the LXC container"
  type        = string
  sensitive   = true
}

variable "container_ip" {
  description = "IP address for the container"
  type        = string
  default     = "192.168.88.129/24"
}

variable "container_gateway" {
  description = "Network gateway for the container"
  type        = string
  default     = "192.168.88.1"
}

variable "container_cores" {
  description = "Number of CPU cores for the container"
  type        = number
  default     = 1
}

variable "container_memory" {
  description = "Amount of memory in MB for the container"
  type        = number
  default     = 512
}


variable "ssh_keys" {
  description = "List of SSH public keys to add to the container"
  type        = list(string)
  default     = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJLmFQn2IqeoqXREB5w3UW0paUv4/7ts+SwvhFyfVyS5 hanif@labs"
  ]
}