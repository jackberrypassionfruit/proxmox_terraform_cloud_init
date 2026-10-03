# main.tf
resource "proxmox_vm_qemu" "web_server" {
  count       = var.vm_count
  name        = "geek-rke2-${count.index + 1}"
  target_node = "pve"
  clone       = "debian-cloud"
  cipassword = var.vm_password
  agent       = 1
  os_type     = "cloud-init"
  cpu { 
    cores = 2 
    sockets = 1
  }
  memory      = 2048
  scsihw      = "virtio-scsi-single"
  bootdisk    = "scsi0"
  boot        = "order=scsi0"

  serial {
    id   = 0
    type = "socket"
  }
  vga {
    type = "serial0"
  }

  disks {
    scsi {
      scsi0 {
        disk {
          size    = "3G"
          storage = "local-lvm"
        }
      }
    }
    ide {
      ide2 {
        cloudinit {
          storage = "local-lvm"
        }
      }
    }
  }

  network {
    id = 0
    model  = "virtio"
    bridge = "vmbr0"
  }

  # Cloud-init settings
  ipconfig0  = "ip=192.168.2.${50 + count.index}/24,gw=192.168.2.1"
  nameserver = "8.8.8.8"
  ciuser     = "debian"
  sshkeys    = file("~/.ssh/id_ed25519.pub")

  lifecycle {
    ignore_changes = [
      network,
    ]
  }
}
