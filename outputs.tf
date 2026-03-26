data "libvirt_domain_interface_addresses" "ubuntu" {
  domain = libvirt_domain.vm.name
  source = "lease" # optional: "lease" (DHCP), "agent" (qemu-guest-agent), or "any"
}
output "vm_name" {
  value = libvirt_domain.vm.name
}

output "vm_ip" {
  description = "IP address of the VM"
  value       = length(data.libvirt_domain_interface_addresses.ubuntu.interfaces) > 0 && length(data.libvirt_domain_interface_addresses.ubuntu.interfaces[0].addrs) > 0 ? data.libvirt_domain_interface_addresses.ubuntu.interfaces[0].addrs[0].addr : "No IP address found"
}

output "instructions" {
  value = <<-EOF

    Virtual machines have been created!

    To find IP addresses assigned by DHCP:
      sudo virsh domifaddr ubuntu-vm
      

    Or check the DHCP leases:
      sudo virsh net-dhcp-leases default

    To connect via SSH (once you know the IP):
      ssh admin@<IP-ADDRESS>
      Password: ******

    To view VM console:
      sudo virsh console ubuntu-vm

    To connect via VNC:
      1. Find VNC port: sudo virsh domdisplay ubuntu-vm
      2. Connect with VNC client to that address

    Note: It may take 30-60 seconds after boot for cloud-init to complete
          and the SSH server to be available.
  EOF
}