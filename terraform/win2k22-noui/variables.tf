variable "server_name" {
    type = string
    description = "Name of server to build"
}

variable "cpus" {
    type = number
    description = "Number of CPUs"
}

variable "memory" {
    type = number
    default = 0.5
    description = "GB of RAM"
}

variable "notes" {
    type = string
    description = "Note associated with Machine in Hyper-V"
    default = ""
}
