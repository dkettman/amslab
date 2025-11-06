terraform {
  required_providers {
    hyperv = {
      source  = "taliesins/hyperv"
      version = "1.2.1"
    }
  }
}

provider "hyperv" {
  user     = "Work"
  password = "Zaxxon1!"
  # host     = "192.168.68.72"
  host     = "127.0.0.1"
  insecure = true
  https    = false
  port     = 5985
  use_ntlm = false
}

locals {
  win2k22-noui = {
    "amslab-dc01" = {
      cpus   = 1
      memory = 1
    }
    "amslab-sql01" = {
      cpus   = 2
      memory = 4
    }
  }
  win2k22 = {
    "amslab-app01" = {
      cpus   = 2
      memory = 4
    }
  }
}

module "win2k22-noui" {
  source      = "./win2k22-noui"
  for_each    = local.win2k22-noui
  server_name = each.key
  cpus        = each.value.cpus
  memory      = each.value.memory
}

module "win2k22" {
  source = "./win2k22"
  for_each    = local.win2k22
  server_name = each.key
  cpus        = each.value.cpus
  memory      = each.value.memory
}
