packer {
  required_plugins {
    hyperv = {
      source  = "github.com/hashicorp/hyperv"
      version = "~> 1"
    }
  }
}

source "hyperv-vmcx" "win2k22-noui" {
  clone_from_vmcx_path = "./output-win2k22-noui/"
  output_directory = "./vms/"
  generation           = 2

  switch_name = "AMSLab"
  # mac_address = "0000deadbeef"

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

# source "hyperv-iso" "win2k22" {
#  iso_url      = "file:///F:/LabSources/ISOs/en-us_windows_server_2022_updated_april_2022_x64_dvd_d428acee.iso"
#  iso_checksum = "sha256:1E5C4A4EA7BB51DAAC00D16D070992EC6F863BA5691401CC52CACC1DE6BF5FDC"
#  cd_files     = ["./win2k22/*"]

#  generation = 2

#  switch_name = "LAN"
#  mac_address = "0000deadbeef"

#  enable_secure_boot = true
#  enable_tpm         = true

#  communicator   = "winrm"
# winrm_username = "admin"
# winrm_password = "New123Pass!!"
# winrm_use_ssl  = false
# winrm_insecure = true

# boot_command = ["<spacebar>"]
# boot_wait    = "2s"

# shutdown_command = "shutdown /s /t 0"
#}

build {
  name = "amslab-dc01"
  sources = ["source.hyperv-vmcx.win2k22-noui"] #, "source.hyperv-iso.win2k22"]
  provisioner "powershell" {
    script = "./scripts/setup-win2k22-servers.ps1"
  }
}
