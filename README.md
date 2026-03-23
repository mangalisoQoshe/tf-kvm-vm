# tf-kvm-vm

A Terraform module for provisioning KVM virtual machines on a local hypervisor using the [dmacvicar/libvirt](https://registry.terraform.io/providers/dmacvicar/libvirt/latest) provider. It supports UEFI/Secure Boot configuration, virtio networking, QCOW2 disk backing stores, and cloud image provisioning via Packer-built base images.


---

## Usage

```terraform
module "tf_vm" {
  source = "../tf-kvm-vm"

  base_image_name = "ubuntu-cloud.qcow2"
  base_image_path = "${path.module}/../ubuntu-cloud.qcow2"
  vm_name         = "ubuntu-vm"
  vm_disk_name    = "ubuntu-cloud-vol.qcow2"
}

output "vm_name" {
  value = module.tf_vm.vm_name
}

output "vm_ip" {
  value = module.tf_vm.vm_ip
}
```



## Workflow

```bash
# 1. Initialise providers and modules
terraform init

# 2. Preview the execution plan
terraform plan

# 3. Provision the VM
terraform apply

# 4. Tear down when done
terraform destroy
```

---
