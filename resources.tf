resource "proxmox_virtual_environment_download_file" "alphine_image_20" {
  content_type = "vztmpl"
  datastore_id = "local"
  node_name = var.node_name
  url = "http://download.proxmox.com/images/system/alpine-3.20-default_20240908_amd64.tar.xz"
  overwrite = true
  file_name = "alpine-3.20-default_20240908_amd64.tar.xz"
}


resource "proxmox_virtual_environment_download_file" "ubuntu_image_22" {
  content_type = "vztmpl"
  datastore_id = "local"
  node_name = var.node_name
  url = "http://download.proxmox.com/images/system/ubuntu-22.04-standard_22.04-1_amd64.tar.zst"
  overwrite = true
  file_name = "ubuntu-22.04-standard_22.04-1_amd64.tar.zst"
}


resource "proxmox_virtual_environment_download_file" "ubuntu_iso" {
  content_type = "iso"
  datastore_id = "local"
  node_name = var.node_name
  url = "https://releases.ubuntu.com/jammy/ubuntu-22.04.5-live-server-amd64.iso"
  file_name = "ubuntu-22.04.5-live-server-amd64.iso"
  overwrite = true
  verify = false
  upload_timeout = 1800
}

resource "proxmox_virtual_environment_download_file" "ubuntu_cloud_image" {
  content_type = "iso"
  datastore_id = "local"
  node_name = var.node_name
  url = "https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img"
}