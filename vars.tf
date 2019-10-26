variable "agent_vm_size" {
  type    = string

}

variable "vm_count" {
  type    = string

}
variable "vnet_name" {
  type    = string
}


variable "address_space" {
  description = "The address space that is used by the virtual network."
}

variable "subnet_prefixes" {
  description = "The address prefix to use for the subnet."
}

variable "network_policy" {
  description = "Network policy to be used with Azure CNI. Either azure or calico."
}

variable "dns_prefix" {
  type = string
}


variable "resource_group_name" {
  type = string
}

variable "resource_group_location" {
  type = string
}

variable "service_principal_id" {
  type = string
}

variable "service_principal_secret" {
  type = string
}



variable "gc_enabled" {
  type    = string
  default = "true"
}
