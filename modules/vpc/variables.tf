variable "region" {
  type        = string
  description = "The AWS Region for this VPC to be launched in"

  //TODO: Provide default for US-East-1
}

variable "availability_zone" {
  type        = string # list(string)
  description = "The availability zone(s) used by this VPC module"

  //TODO: Provide default for US-East-1
}

variable "create_vpc" {
  type        = bool
  description = "Toggle to enable / disable this module creating a VPC"
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
  default     = "10.0.0.0/24"
}

variable "wlz_ingress_cidr_block" {
  type        = list(string)
  description = "List of CIDR blocks for SSH access"

  # NOTE: this is decidedly NOT a best-practice!
  default = ["0.0.0.0/0"]
}

variable "tags" {
  type        = map(any)
  description = "Default tags for all resources created by the VPC module inside the wavelength module."

  default = {
    purpose          = "Wavelength"
    terraformManaged = true
  }
}

variable "tags_internet_gw" {
  type        = map(any)
  description = "Additional tags for the module created internet gateway"

  default = {
    type = "igw"
  }
}

variable "tags_managed_vpc" {
  type        = map(any)
  description = "Additional tags for the module created VPC"

  default = {
    type = "vpc"
  }
}

variable "tags_region_route_table" {
  type        = map(any)
  description = "Additional tags for the module created route table"

  default = {
    type = "routeTable"
  }
}

variable "tags_region_securitygroup" {
  type        = map(any)
  description = "Additional tags for the module created security group"

  default = {
    type = "securityGroup"
  }
}

variable "tags_region_subnet" {
  type        = map(any)
  description = "Additional tags for the module created subnet"

  default = {
    type = "awsRegionSubnet"
  }
}

locals {
  tags_internet_gw        = merge(var.tags, var.tags_internet_gw)
  tags_managed_vpc        = merge(var.tags, var.tags_managed_vpc)
  tags_region_route_table = merge(var.tags, var.tags_region_route_table)
  tags_region_securitygroup  = merge(var.tags, var.tags_region_securitygroup)
  tags_region_subnet      = merge(var.tags, var.tags_region_subnet)
}
