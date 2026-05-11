# vCenter authentication
vsphere_user       = "administrator@vsphere.local"
vsphere_password   = "Gandoki2469$#"
vsphere_server     = "10.0.0.120"

# vSphere environment
vsphere_datacenter = "DC1"
vsphere_datastore  = "datastore1"
vsphere_network    = "VM Network"
vsphere_host       = "10.0.0.110"

# -----------------------------
# Ubuntu Template Deployment
# -----------------------------

# Name of the Ubuntu template in vCenter
template_name = "Ubuntu-Template"

# Name of the new VM to create
vm_name = "ubuntu-server-01"

# Networking for the new VM (NOT the template IP)

# (Optional) VM password if you use provisioners later

