packer {
  required_plugins {
    hyperv = {
      source  = "github.com/hashicorp/hyperv"
      version = "~> 1"
    }
  }
}

# source "hyperv-iso" "unattended-noui" {
#   iso_url      = "file://c/Users/Work/Downloads/unattend.iso"
#   iso_checksum = "sha256:AB953EE1EEE0D81C6836B1B39A8DFB4C3ACBA96CA1CF5150CB559D952EB21C74"
# }

source "hyperv-iso" "win2k22-noui" {
  iso_url      = "file:///F:/LabSources/ISOs/en-us_windows_server_2022_updated_april_2022_x64_dvd_d428acee.iso"
  iso_checksum = "sha256:1E5C4A4EA7BB51DAAC00D16D070992EC6F863BA5691401CC52CACC1DE6BF5FDC"
  cd_files     = ["./win2k22-noui/*"]

  generation = 2

  switch_name = "LAN"
  mac_address = "0000deadbeef"

  enable_secure_boot = true
  enable_tpm         = true

  communicator   = "winrm"
  winrm_username = "admin"
  winrm_password = "New123Pass!!"
  winrm_use_ssl  = false
  winrm_insecure = true

  boot_command = ["<spacebar>"]
  boot_wait    = "2s"

  shutdown_command = "shutdown /s /t 0"
}

source "hyperv-iso" "win2k22" {
  iso_url      = "file:///F:/LabSources/ISOs/en-us_windows_server_2022_updated_april_2022_x64_dvd_d428acee.iso"
  iso_checksum = "sha256:1E5C4A4EA7BB51DAAC00D16D070992EC6F863BA5691401CC52CACC1DE6BF5FDC"
  cd_files     = ["./win2k22/*"]

  generation = 2

  switch_name = "LAN"
  mac_address = "0000deadbeef"

  enable_secure_boot = true
  enable_tpm         = true

  communicator   = "winrm"
  winrm_username = "admin"
  winrm_password = "New123Pass!!"
  winrm_use_ssl  = false
  winrm_insecure = true

  boot_command = ["<spacebar>"]
  boot_wait    = "2s"

  shutdown_command = "shutdown /s /t 0"
}


build {
  sources = ["source.hyperv-iso.win2k22-noui", "source.hyperv-iso.win2k22"]
  provisioner "powershell" {
    script = "./scripts/setup-win2k22-servers.ps1"
  }
}