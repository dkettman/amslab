terraform {
  required_providers {
    hyperv = {
      source  = "taliesins/hyperv"
      version = "1.2.1"
    }
  }
}

resource "hyperv_vhd" "diff_win2k22-noui" {
  path        = "F:\\Hyper-V\\${var.server_name}.vhdx"
  parent_path = "c:\\users\\Work\\git\\packer\\output-win2k22-noui\\Virtual Hard Disks\\packer-win2k22-noui.vhdx"
  vhd_type    = "Differencing"
}

resource "hyperv_machine_instance" "win2k22-noui" {
  name                   = var.server_name
  generation             = 2
  checkpoint_type        = "Disabled"
  notes                  = var.notes
  processor_count        = var.cpus
  memory_startup_bytes = var.memory*1073741824 # Multiplies out to `var.memory` GB of RAM
  smart_paging_file_path = "C:\\ProgramData\\Microsoft\\Windows\\Hyper-V"
  snapshot_file_location = "C:\\ProgramData\\Microsoft\\Windows\\Hyper-V"

  static_memory = true
  state         = "Running"

  # Configure firmware
  vm_firmware {
    enable_secure_boot              = "On"
    preferred_network_boot_protocol = "IPv4"
    console_mode                    = "None"
    pause_after_boot_failure        = "Off"
    boot_order {
      boot_type           = "HardDiskDrive"
      controller_number   = "0"
      controller_location = "0"
    }
  }

  # Configure processor
  vm_processor {
  }

  # Configure integration services
  integration_services = {
    "Guest Service Interface" = true
    "Heartbeat"               = true
    "Key-Value Pair Exchange" = true
    "Shutdown"                = true
    "Time Synchronization"    = true
    "VSS"                     = true
  }

  # Create a network adaptor
  network_adaptors {
    name        = "Ethernet0"
    switch_name = "AMSLab"
  }

  # Create a hard disk drive
  hard_disk_drives {
    controller_type     = "Scsi"
    controller_number   = "0"
    controller_location = "0"
    path                = hyperv_vhd.diff_win2k22-noui.path
  }
}
