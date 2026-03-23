variable "base_image_name" {
  description = "Name of the base QCOW2 image volume built by Packer"
  type        = string
}

variable "base_image_path" {
  description = "Local path to the QCOW2 base image produced by Packer"
  type        = string
}

variable "base_image_pool" {
  description = "Libvirt storage pool where the base image will be stored"
  type        = string
  default     = "default"
}

variable "cpu_mode" {
  description = "CPU mode for the VM (e.g. host-passthrough, host-model, custom)"
  type        = string
  default     = "host-passthrough"
}

variable "disk_driver_type" {
  description = "Disk image format used by the QEMU driver"
  type        = string
  default     = "qcow2"
}

variable "disk_target_bus" {
  description = "Bus type for the primary OS disk (e.g. virtio, scsi, sata)"
  type        = string
  default     = "virtio"
}

variable "disk_target_dev" {
  description = "Target device name for the primary OS disk (e.g. vda, sda)"
  type        = string
  default     = "vda"
}

variable "ip_lookup_source" {
  description = "Source for domain interface address lookup (lease, agent, or any)"
  type        = string
  default     = "lease"
}

variable "network_model" {
  description = "NIC model type for the network interface (e.g. virtio, e1000)"
  type        = string
  default     = "virtio"
}

variable "network_name" {
  description = "Name of the libvirt network to attach the VM to"
  type        = string
  default     = "default"
}

variable "network_wait_for_ip_source" {
  description = "Source to use when waiting for an IP (any, lease, or agent)"
  type        = string
  default     = "any"
}

variable "network_wait_for_ip_timeout" {
  description = "Timeout in seconds to wait for the VM to receive an IP address"
  type        = number
  default     = 300
}


variable "vm_disk_name" {
  description = "Name of the VM disk volume cloned from the base image"
  type        = string
}

variable "vm_disk_pool" {
  description = "Libvirt storage pool where the VM disk will be stored"
  type        = string
  default     = "default"
}

variable "vm_disk_size" {
  description = "Size of the VM disk in bytes"
  type        = number
  default     = 25 # 25 GiB
}

variable "vm_memory" {
  description = "Amount of RAM allocated to the VM"
  type        = number
  default     = 1024
}

variable "vm_memory_unit" {
  description = "Unit for VM memory allocation (e.g. MiB, GiB)"
  type        = string
  default     = "MiB"
}

variable "vm_name" {
  description = "Name of the libvirt domain (virtual machine)"
  type        = string

}

variable "vm_running" {
  description = "Whether the VM should be running after creation"
  type        = bool
  default     = true
}

variable "vm_type" {
  description = "Hypervisor type for the VM domain"
  type        = string
  default     = "kvm"
}

variable "vm_vcpu" {
  description = "Number of virtual CPUs allocated to the VM"
  type        = number
  default     = 1
}

variable "vnc_autoport" {
  description = "Whether to automatically assign a VNC port"
  type        = string
  default     = "yes"
}

variable "vnc_listen_address" {
  description = "IP address the VNC server listens on"
  type        = string
  default     = "127.0.0.1"
}