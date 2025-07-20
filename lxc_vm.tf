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




resource "proxmox_virtual_environment_vm" "devops-lab" {
  name = "devops-lab"
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
              address = "192.168.88.133/24"
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

  connection {
    type        = "ssh"
    user        = "hanif"
    host        = "192.168.88.133"
    private_key = file("~/.ssh/labs")
    password    = var.container_password
    timeout     = "5m"
  }

  provisioner "remote-exec" {
    inline = [
        "echo 'Waiting for cloud-init to complete...'",
        "while [ ! -f /var/lib/cloud/instance/boot-finished ]; do sleep 2; done",
        "echo 'Cloud-init completed, waiting for package manager to be free...'",
        "while sudo fuser /var/lib/dpkg/lock >/dev/null 2>&1; do sleep 2; done",
        "while sudo fuser /var/lib/dpkg/lock-frontend >/dev/null 2>&1; do sleep 2; done",
        "while sudo fuser /var/lib/apt/lists/lock >/dev/null 2>&1; do sleep 2; done",
        "echo 'Package manager is now free, starting Docker installation...'",
        "export DEBIAN_FRONTEND=noninteractive",
        "export NEEDRESTART_MODE=a",
        "sudo -E apt-get update -y",
        "sudo -E apt-get install -y ca-certificates curl gnupg lsb-release",
        "sudo mkdir -m 0755 -p /etc/apt/keyrings",
        "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg",
        "echo \"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable\" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null",
        "sudo -E apt-get update -y",
        "sudo -E apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin",
        "sudo usermod -aG docker hanif",
        "sudo systemctl enable docker",
        "sudo systemctl start docker",
        "echo 'Docker installation completed successfully!'",
        "docker --version",
        "sudo docker run hello-world"
    ]
  }
}
