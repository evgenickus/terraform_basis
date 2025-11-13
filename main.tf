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
  name         = "tf_test_rg_1"
  account_id   = var.account_id
  gid          = var.gid
  def_net_type = "NONE"
  description  = "Resource Group PolyakovEE"
  permanently = true
}

resource "decort_vins" "vins" {
  name = "tf_test_network_1"
  rg_id = decort_resgroup.rg.rg_id
  permanently = true
}

resource "decort_kvmvm" "comp_1" {
  name = "tf_test_compute_1"
  rg_id = decort_resgroup.rg.rg_id
  driver = "KVM_X86"
  cpu = 2
  ram = 4096
  chipset = "i440fx"
  image_id = 8
  description = "VM_1 For Testing tf_test_network_1"
  permanently = true
  network {
    net_type = "VINS"
    net_id = decort_vins.vins.id
  }
}

resource "decort_kvmvm" "comp_2" {
  name = "tf_test_compute_2"
  rg_id = decort_resgroup.rg.rg_id
  driver = "KVM_X86"
  cpu = 2
  ram = 4096
  chipset = "i440fx"
  image_id = 8
  description = "VM_2 For Testing tf_test_network_1"
  permanently = true
  network {
    net_type = "VINS"
    net_id = decort_vins.vins.id
  }
}
