terraform {
  required_providers {
    vsphere = {
      source  = "vmware/vsphere"
      version = "~> 2.12"
    }
  }
}

provider "vsphere" {
  user                 = "administrator@vsphere.local"
  password             = "Gandoki2469$#"
  vsphere_server       = "10.0.0.120"
  allow_unverified_ssl = true
}

# -----------------------
# vCenter Objects
# -----------------------

data "vsphere_datacenter" "dc" {
  name = "DC1"
}

data "vsphere_datastore" "datastore" {
  name          = "datastore1"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name          = "VM Network"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_host" "host" {
  name          = "10.0.0.110"
  datacenter_id = data.vsphere_datacenter.dc.id
}

# -----------------------
# VM with ISO boot (CentOS)
# -----------------------

resource "vsphere_virtual_machine" "centos_vm" {
  name             = "centos8-vm"
  resource_pool_id = data.vsphere_host.host.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus = 2
  memory   = 2048
  guest_id = "centos7_64Guest"

  # -----------------------
  # NETWORK
  # -----------------------
  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = "vmxnet3"
  }

  # -----------------------
  # DISK
  # -----------------------
  disk {
    label            = "disk0"
    size             = 40
    thin_provisioned = true
  }

  # -----------------------
  # ISO BOOT (CentOS 7)
  # -----------------------
  cdrom {
    datastore_id = data.vsphere_datastore.datastore.id
    path         = "[datastore1] CentOS-8.5.iso"
  }

  # -----------------------
  # BOOT FIX (IMPORTANT)
  # -----------------------
  boot_delay         = 10000
  boot_retry_enabled = true
  boot_retry_delay   = 10000

  extra_config = {
    "bios.bootOrder" = "cdrom,disk,ethernet"
    "bios.forceSetupOnce" = "TRUE"
  }

  # -----------------------
  # FIX: Prevent IP timeout error
  # -----------------------
  wait_for_guest_ip_timeout  = 0
  wait_for_guest_net_timeout = 0

  poweron_timeout = 300
}
