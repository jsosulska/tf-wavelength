variable "create_vpc" {
  type        = bool
  default     = false
  description = "Toggle to enable / disable VPC creation"
}

variable "profile" {
  type        = string
  description = "AWS Credentials Profile to use"
  default     = "default"
}

variable "region" {
  type        = string
  default     = "us-east-1"
  description = "This is the AWS region."
}

variable "tags_carrier_gw" {
  type        = map(string)
  description = "Carrier Gateway Tags"

  default = {
    name = "carrierGateway"
  }
}

variable "tags_wavelength" {
  type        = map(string)
  description = "default Tags"

  default = {
    purpose          = "Wavelength"
    terraformManaged = true
  }
}

variable "tags_wlz_route_table" {
  type        = map(string)
  description = "Wavelength Zone Route Table Tags"

  default = {
    name = "routeTable"
  }
}

variable "tags_wlz_securitygroup" {
  type        = map(string)
  description = "Wavelength Zone security group Tags"

  default = {
    name = "wlzSecurityGroup"
  }
}

variable "tags_wlz_subnet" {
  type        = map(string)
  description = "Additional tags for the module created subnet"

  default = {
    type = "wlzSubnet"
  }
}

variable "vpc_id" {
  type        = string
  description = "The id of the specific pre-existing VPC to retrieve."
  default     = ""
}

variable "wlz_cidr_block" {
  type        = string
  description = "The CIDR block for the Wavelength Zone"
  default     = "10.1.4.0/24"
}

locals {
  # see https://www.terraform.io/docs/language/functions/merge.html
  tags_carrier_gw = merge(var.tags_wavelength, var.tags_carrier_gw)
  //tags_wlz_route_table   = merge(var.tags_wavelength, var.tags_wlz_route_table)
  tags_wlz_securitygroup = merge(var.tags_wavelength, var.tags_wlz_securitygroup)
  tags_wlz_subnet        = merge(var.tags_wavelength, var.tags_wlz_subnet)
}
