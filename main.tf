terraform {
  required_providers {
    decort = {
      version = "4.9.4"
      source  = "basis/decort/decort"
    }
  }
}
provider "decort" {
  authenticator        = "decs3o"
  controller_url       = "https://basislab.digitalenergy.online"
  oauth2_url           = "https://sso-basislab.digitalenergy.online"
  app_id               = var.app_id
  app_secret           = var.app_secret
  allow_unverified_ssl = true
}


resource "decort_resgroup" "rg" {
  name = "Elite"
  account_id = 3
  gid = 2001
  def_net_type = "NONE"
  permanently = true
}

resource "decort_vins" "vins" {
  name = "elite_main_nw"
  rg_id = decort_resgroup.rg.rg_id
  ext_net_id = 4
  ext_ip_addr = "10.0.88.202"
  ipcidr = "192.168.199.0/24"
  permanently = true
}

resource "decort_kvmvm" "server" {
  name = "elite_server"
  rg_id = decort_resgroup.rg.rg_id
  driver = "KVM_X86"
  cpu = 2
  ram = 4096
  chipset = "i440fx"
  image_id = 8
  description = "main server"
  permanently = true
  network {
    net_type = "VINS"
    net_id = decort_vins.vins.id
    weight = 50
  }
  network {
    net_type = "EXTNET"
    net_id = 4
  }
}

resource "decort_kvmvm" "balancer" {
  name = "elite_balancer"
  rg_id = decort_resgroup.rg.rg_id
  driver = "KVM_X86"
  cpu = 2
  ram = 4096
  chipset = "i440fx"
  image_id = 8
  description = "server for balance"
  permanently = true
  network {
    net_type = "VINS"
    net_id = decort_vins.vins.id
  }
}

output "decort_resgroup" {
  value = decort_resgroup.rg
}
