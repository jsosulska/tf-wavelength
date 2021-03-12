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

variable "vpc_id" {
  type        = string
  description = "The id of the specific pre-existing VPC to retrieve."
  default     = ""
}

variable "tags_default" {
  type        = map(any)
  description = "default Tags"

  default = {
    Purpose          = "Wavelength"
    TerraformManaged = true
  }
}

variable "tags_internet_gateway" {
  type        = map(any)
  description = "default Tags"

  default = {
    Name = "Internet-Gateway"
  }
}

locals {
  # see https://www.terraform.io/docs/language/functions/merge.html
  igw_tags = merge(var.tags_internet_gateway, var.tags_default)
}

