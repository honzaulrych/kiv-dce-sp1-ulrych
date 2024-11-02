variable "opennebula_endpoint"  {
    description = "Open Nebula endpoint URL"
    default = "https://nuada.zcu.cz/RPC2"
}
variable "opennebula_username"  {
    description = "Open Nebula username"
}
variable "opennebula_password"  {
    description = "Open Nebula login token"
}
variable "cluster_size" {
    description = "Number of cluster nodes"
    default = 3
}
variable "ssh_pubkey" {
    description = "SSH public key used for login as root into the VM instance"
}
variable "admin_user" {
    description = "Username of the admin user"
    default = "root"
}