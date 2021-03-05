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

variable "tags" {
  type        = map(any)
  description = "AWS Tags"

  default = {
    Name = "Wavelength"
  }
}

//local {
//  tags = var.tags != "" ? var.tags : var.predefined_tags
//}
//
//tag_prefix = "Wavelength 42"
//
//name = "${trim(var.tag_prefix)} Internet GW"
