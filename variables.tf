variable "region" {
  type        = string
  default     = "us-east-1"
  description = "This is the AWS region."
}

variable "create_vpc" {
  type        = bool
  default     = false
  description = "Toggle to enable / disable VPC creation"
}

variable "wlz_cidr_block" {
  type        = string
  description = "The CIDR block for the Wavelength Zone"
  default     = "10.0.0.3/24"
}

variable "vpc_id" {
  type        = string
  description = "The id of the specific pre-existing VPC to retrieve."
  default     = ""
}

variable "tags_wavelength" {
  type        = map(any)
  description = "default Tags"

  default = {
    purpose          = "Wavelength"
    terraformManaged = true
  }
}

variable "tags_carrier_gw" {
  type        = map(any)
  description = "Carrier Gateway Tags"

  default = {
    Name = "carrierGateway"
  }
}

variable "tags_wlz_route_table" {
  type        = map(any)
  description = "Wavelength Zone Route Table Tags"

  default = {
    Name = "routeTable"
  }
}

variable "tags_wlz_securitygroup" {
  type        = map(any)
  description = "Wavelength Zone security group Tags"

  default = {
    Name = "wlzSecurityGroup"
  }
}

variable "tags_wlz_subnet" {
  type        = map(any)
  description = "Additional tags for the module created subnet"

  default = {
    type = "wlzSubnet"
  }
}

locals {
  # see https://www.terraform.io/docs/language/functions/merge.html
  tags_carrier_gw        = merge(var.tags_wavelength, var.tags_carrier_gw)
  //tags_wlz_route_table   = merge(var.tags_wavelength, var.tags_wlz_route_table)
  tags_wlz_securitygroup = merge(var.tags_wavelength, var.tags_wlz_securitygroup)
  tags_wlz_subnet        = merge(var.tags_wavelength, var.tags_wlz_subnet)
}

