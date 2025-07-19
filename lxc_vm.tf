resource "proxmox_virtual_environment_container" "mainlab" {
    description = "Ubuntu Linux Container, For development mainlab"
    node_name = var.node_name
    vm_id = 102

    initialization {
        hostname = "mainlab"
        ip_config {
            ipv4 {
                address = "192.168.88.224/24"
                gateway = var.container_gateway
            }
        }

        user_account {
            password = var.container_password
        }
    }

    cpu {
        cores = 4
    }
    memory {
        dedicated = 8192
    }

    disk {
        datastore_id = "local-lvm"
        size = 250
    }

    network_interface {
        bridge = "vmbr0"
        name = "eth0"
    }

    operating_system {
        template_file_id = proxmox_virtual_environment_download_file.ubuntu_image_22.id
        type = "ubuntu"
    }

    features {
        nesting = true
    }

    tags = ["mainlab", "dev"]
}

resource "proxmox_virtual_environment_container" "coolify" {
    description = "Ubuntu Linux Container, For development coolify"
    node_name = var.node_name
    vm_id = 103

    initialization {
        hostname = "coolify"
        ip_config {
            ipv4 {
                address = "192.168.88.125/24"
                gateway = var.container_gateway
            }
        }

        user_account {
            password = var.container_password
        }
    }

    cpu {
        cores = 6
    }

    memory {
        dedicated = 10240
    }

    disk {
        datastore_id = "local-lvm"
        size = 250
    }

    network_interface {
        bridge = "vmbr0"
        name = "eth0"
    }

    operating_system {
        template_file_id = proxmox_virtual_environment_download_file.ubuntu_image_22.id
        type = "ubuntu"
    }

    features {
        nesting = true
    }

    unprivileged = true

    tags = ["coolify", "dev"]
    
}

resource "proxmox_virtual_environment_container" "cloudfalred-gateway" {
    description = "Ubuntu Linux Container, For Cloudflare Gateway"
    node_name = var.node_name
    vm_id = 105

    initialization {
        hostname = "cloudflare-gateway"
        ip_config {
            ipv4 {
                address = "192.168.88.127/24"
                gateway = var.container_gateway
            }
        }

        user_account {
            password = var.container_password
        }
    }

    cpu {
        cores = 1
    }

    memory {
        dedicated = 1024
    }

    disk {
        datastore_id = "local-lvm"
        size = 250
    }

    network_interface {
        bridge = "vmbr0"
        name = "eth0"
    }

    operating_system {
        template_file_id = proxmox_virtual_environment_download_file.ubuntu_image_22.id
        type = "ubuntu"
    }

    features {
        nesting = true
    }

    unprivileged = true

    tags = ["cloudfalred", "tunnel", "gateway"]
}


resource "proxmox_virtual_environment_vm" "ndoro-server" {
    name = "ndoro-server"
    node_name = var.node_name
    cpu {
        cores = 2
    }
    
    memory {
        dedicated = 2048
    }


    disk {
        datastore_id = "local-lvm"
        file_id = proxmox_virtual_environment_download_file.ubuntu_cloud_image.id
        interface    = "virtio0"
        iothread     = true
        discard      = "on"
        size         = 20
    }

    initialization {
        ip_config {
            ipv4 {
                address = "192.168.88.129/24"
                gateway = var.container_gateway
            }
        }
        user_account {
            username = "hanif"
            password = var.container_password
            keys = var.ssh_keys
        }
    }

    network_device {
        bridge = "vmbr0"
    }
}

resource "proxmox_virtual_environment_vm" "quickstack" {
    name = "quickstack"
    node_name = var.node_name
    cpu {
        cores = 4
    }
    
    memory {
        dedicated = 4096
    }


    disk {
        datastore_id = "local-lvm"
        file_id = proxmox_virtual_environment_download_file.ubuntu_cloud_image.id
        interface    = "virtio0"
        iothread     = true
        discard      = "on"
        size         = 120
    }

    initialization {
        ip_config {
            ipv4 {
                address = "192.168.88.130/24"
                gateway = var.container_gateway
            }
        }
        user_account {
            username = "hanif"
            password = var.container_password
            keys = var.ssh_keys
        }
    }

    network_device {
        bridge = "vmbr0"
    }
}


resource "proxmox_virtual_environment_vm" "k3s-master" {
  name = "k3s-master"
  node_name = var.node_name

  cpu {
      cores = 2
  }

  memory {
      dedicated = 2048
  }

  disk {
      datastore_id = "local-lvm"
      file_id = proxmox_virtual_environment_download_file.ubuntu_cloud_image.id
      interface = "virtio0"
      iothread = true
      discard = "on"
      size = 40
  }

  initialization {
      ip_config {
          ipv4 {
              address = "192.168.88.131/24"
              gateway = var.container_gateway
          }
      }
      user_account {
          username = "hanif"
          password = var.container_password
          keys = var.ssh_keys
      }
  }

  network_device {
      bridge = "vmbr0"
  }
}


