# Base Image built by Packer
resource "libvirt_volume" "base_image" {
  name = "${var.base_image_name}"
  pool = "${var.base_image_pool}"

  target = {
    format = {
      type = "qcow2"
    }
 
  }

  create = {
    content = {
      url = "${path.root}/${var.base_image_path}"
    }
  }
}

# Create VM disk from base image
resource "libvirt_volume" "vm_disk" {
  name     = "${var.vm_disk_name}"
  pool     = "${var.vm_disk_pool}"
  capacity = "${var.vm_disk_size}" * 1024 * 1024 * 1024 

  target = {
    format = {
      type = "qcow2"
    }

  }

  backing_store = {


    path = libvirt_volume.base_image.path
    format = {
      type = "qcow2"
    }

  }

}


# VM Domain 
resource "libvirt_domain" "vm" {
  name        = "${var.vm_name}"
  memory      = "${var.vm_memory}"
  memory_unit = "MiB"
  vcpu        = "${var.vm_vcpu}"
  type        = "kvm"
  running     = true


  cpu = {
    mode = "${var.cpu_mode}"
  }

# UEFI and Secure Boot configuration
  os = {
    type            = "hvm"
    type_arch       = "x86_64"
    type_machine    = "q35"
    firmware        = "efi"
    loader          = "/usr/share/OVMF/OVMF_CODE_4M.fd"
    loader_format   = "raw"
    loader_readonly = "yes"
    loader_secure   = "no"
    loader_type     = "pflash"
  }
    features = {
      acpi = true
    }

  devices = {

    disks = [
      # Main OS disk
      {
        source = {
          volume = {
            pool   = libvirt_volume.vm_disk.pool
            volume = libvirt_volume.vm_disk.name
          }
        }
        target = {
          dev = "${var.disk_target_dev}"
          bus = "${var.disk_target_bus}"
        }
         driver = {
           type  = "qcow2"
         }
      }
    ]

    # Network interfaces
    interfaces = [
      {
        
        model = { type = "${var.network_model}" }

        source = {
          network = {
            network = "${var.network_name}"
          }
        }
        wait_for_ip = {
          timeout = "${var.network_wait_for_ip_timeout}"
          source  = "${var.network_wait_for_ip_source}"
        }

      }
    ]
    graphics = [{
      vnc = {
        autoport = "${var.vnc_autoport}"
        listen   = "${var.vnc_listen_address}"
      }
    }]

    consoles = [
      { type = "pty", target = { type = "serial", port = 0 } }
    ]

    channels = [ {
      source = {
        unix = {
          mode = "bind"
        }
      }
      target = {
        type = "virtio"
        virt_io = {
          name = "org.qemu.guest_agent.0"
        }
      }
    } ]


  }


}


