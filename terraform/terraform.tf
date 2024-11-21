terraform {
  required_providers {
    opennebula = {
      source = "OpenNebula/opennebula"
      version = "~> 1.2"
    }
  }
}

provider "opennebula" {
  endpoint      = "${var.opennebula_endpoint}"
  username      = "${var.opennebula_username}"
  password      = "${var.opennebula_password}"
}

# resource "opennebula_image" "os-image" {
#     name = "DEMO - Ubuntu Minimal 24.04"
#     datastore_id = 101
#     persistent = false
#     path = "https://marketplace.opennebula.io//appliance/44077b30-f431-013c-b66a-7875a4a4f528/download/0"
#     permissions = "600"
# }

resource "opennebula_virtual_machine" "backend-node" {
  count = var.cluster_size
  name = "sp-1-be-node-${count.index + 1}"
  description = "Backend node VM"
  cpu = 1
  vcpu = 1
  memory = 1024
  permissions = "600"
  group = "users"

  context = {
    NETWORK  = "YES"
    HOSTNAME = "$NAME"
    SSH_PUBLIC_KEY = "${var.ssh_pubkey}"
  }
  os {
    arch = "x86_64"
    boot = "disk0"
  }

  disk {
    image_id = 688 #opennebula_image.os-image.id
    target   = "vda"
    size     = 6000 # 6GB
  }

  graphics {
    listen = "0.0.0.0"
    type   = "vnc"
  }

  nic {
    network_id = 3
  }

  connection {
    type = "ssh"
    user = "root"
    host = "${self.ip}"
    private_key = "${file("/var/iac-dev-container-data/id_ecdsa")}"
  }

  tags = {
    role = "compute"
  }
}

resource "opennebula_virtual_machine" "frontend-node" {
  name = "sp-1-fe-node"
  description = "Frontend node VM"
  cpu = 1
  vcpu = 1
  memory = 1024
  permissions = "600"
  group = "users"

  context = {
    NETWORK  = "YES"
    HOSTNAME = "$NAME"
    SSH_PUBLIC_KEY = "${var.ssh_pubkey}"
  }
  os {
    arch = "x86_64"
    boot = "disk0"
  }

  disk {
    image_id = 688 #opennebula_image.os-image.id
    target   = "vda"
    size     = 6000 # 6GB
  }

  graphics {
    listen = "0.0.0.0"
    type   = "vnc"
  }

  nic {
    network_id = 3
  }

  connection {
    type = "ssh"
    user = "root"
    host = "${self.ip}"
    private_key = "${file("/var/iac-dev-container-data/id_ecdsa")}"
  }

  tags = {
    role = "controller"
  }
}

#-------OUTPUTS ------------

output "frontend_node" {
  value = "${opennebula_virtual_machine.frontend-node.*.ip}"
}

output "backend_nodes" {
  value = "${opennebula_virtual_machine.backend-node.*.ip}"
}

resource "local_file" "hosts_cfg" {
  content = templatefile("inventory.tmpl",
    {
      vm_admin_user = var.admin_user,
      frontend_node = opennebula_virtual_machine.frontend-node.*.ip,
      backend_nodes = opennebula_virtual_machine.backend-node.*.ip
    })
  filename = "../dynamic_inventories/cluster"
}

resource "local_file" "nginx_cfg" {
  content = templatefile("config.tmpl",
    {
      backend_nodes = opennebula_virtual_machine.backend-node.*.ip
    })
  filename = "../dynamic_inventories/backend-proxy.conf"
}
