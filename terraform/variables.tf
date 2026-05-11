# -----------------------------
# vSphere connection settings
# -----------------------------

variable "vsphere_user" {
  description = "vSphere username"
  type        = string
}

variable "vsphere_password" {
  description = "vSphere password"
  type        = string
  sensitive   = true
}

variable "vsphere_server" {
  description = "vCenter server IP or FQDN"
  type        = string
}

# -----------------------------
# vSphere environment
# -----------------------------

variable "vsphere_datacenter" {
  description = "Datacenter name in vCenter"
  type        = string
}

variable "vsphere_datastore" {
  description = "Datastore name"
  type        = string
}

variable "vsphere_network" {
  description = "VM network (port group)"
  type        = string
}

variable "vsphere_host" {
  description = "ESXi host name"
  type        = string
}

# -----------------------------
# VM settings
# -----------------------------

variable "template_name" {
  description = "VM template name (Ubuntu or CentOS 9)"
  type        = string
}

variable "vm_name" {
  description = "Name of the VM to create"
  type        = string
}

variable "vm_cpus" {
  description = "Number of CPUs"
  type        = number
  default     = 2
}

variable "vm_memory" {
  description = "Memory in MB"
  type        = number
  default     = 2048
}
