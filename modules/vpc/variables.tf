variable "region" {
  type        = string
  description = "This is the AWS region."
}

variable "availability_zone" {
  type        = string # list(string)
  description = "TODO"
}

variable "create_vpc" {
  type        = bool
  description = "Toggle to enable / disable VPC creation"
  default     = false
}

variable "vpc_cidr_block" {
  type        = string
  description = "The CIDR block for the VPC"
  default     = "10.0.0.0/22"
}

variable "subnet_cidr_block" {
  type        = string
  description = "The CIDR block for the Subnet"
  default     = "10.0.1.0/24"
}

variable "wlz_ingress_cidr_block" {
  type        = list(string)
  description = "List of CIDR blocks for SSH access"

  # NOTE: this is decidedly NOT a best-practice!
  default = ["0.0.0.0/0"]
}

variable "tags" {
  type        = map(any)
  description = "TODO"

  default = {
    purpose          = "Wavelength"
    terraformManaged = true
  }
}

variable "tags_managed_vpc" {
  type        = map(any)
  description = "TODO"

  default = {
    type = "vpc"
  }
}

variable "tags_region_subnet" {
  type        = map(any)
  description = "TODO"

  default = {
    type = "subnet"
  }
}

variable "tags_internet_gw" {
  type        = map(any)
  description = "TODO"

  default = {
    type = "igw"
  }
}

variable "tags_region_route_table" {
  type        = map(any)
  description = "TODO"

  default = {
    type = "Region Route Table"
  }
}

variable "tags_securitygroup_wlz" {
  type        = map(any)
  description = "TODO"

  default = {
    type = "Security Group"
  }
}

locals {
  tags_managed_vpc        = merge(var.tags, var.tags_managed_vpc)
  tags_region_subnet      = merge(var.tags, var.tags_region_subnet)
  tags_internet_gw        = merge(var.tags, var.tags_internet_gw)
  tags_region_route_table = merge(var.tags, var.tags_region_route_table)
  tags_securitygroup_wlz  = merge(var.tags, var.tags_securitygroup_wlz)
}
